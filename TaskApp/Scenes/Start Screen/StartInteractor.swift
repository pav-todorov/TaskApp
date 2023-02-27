//
//  StartInteractor.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit
import AuthenticationServices
import FacebookLogin
import FacebookCore

// MARK: Start Interactor
struct StartInteractor: StartInteractive {
    
    // MARK: Start Interactive
    func login(with credentials: (email: String, password: String),
               presenter: StartPresentable) {
        
        presenter.showLoadingIndicator()
        Task {
            do {
                var alertType = AlertType.serverError
                
                switch try await APIService.shared.fetchUserProfile(with: credentials.0,
                                                                    and: credentials.1) {
                case .success: alertType = .internalLoginSuccess
                case .wrongCredentials: alertType = .wrongCredentials
                case .serverError: alertType = .serverError
                case .wrongURL: alertType = .wrongCredentials
                }
                
                presenter.dismissLoadingIndicator(completion: {
                    presenter.showAlertMessage(with: alertType)
                })
            } catch {
                presenter.dismissLoadingIndicator(completion: {
                    presenter.showAlertMessage(with: AlertType.systemError(error))
                })
            }
        }
    }
    
    func appleLogin(delegate: StartViewable) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = delegate
        controller.presentationContextProvider = delegate
        controller.performRequests()
    }
    
    func googleLogin() {
        
    }
    
    func facebookLogin(delegate: StartViewable, presenter: StartPresentable) {
        guard let viewController = delegate as? UIViewController else { return }
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [ .publicProfile,.email ], viewController: viewController) { loginResult in
            
            switch loginResult {
            case .success(_, _, token: let token):
                
                if let accessToken = token, !accessToken.isExpired {
                    let request = FacebookLogin.GraphRequest(graphPath: "me",
                                                             parameters: ["fields" : "email, name"],
                                                             tokenString: accessToken.tokenString,
                                                             version: nil,
                                                             httpMethod: .get)
                    request.start(completionHandler: { connection, result, error in
                        if error != nil {
                            presenter.showAlertMessage(with: .facebookLoginFailed(error: error!))
                        } else if let userData = result as? [String : AnyObject] {
                            guard let givenName = userData["name"] as? String,
                                  let email = userData["email"] as? String else { return }
                            
                            presenter.showAlertMessage(with: .facebookLoginWelcome(givenName: givenName, email: email))
                        }
                    })
                }
                
            case .cancelled: break
            case .failed(let error):
                presenter.showAlertMessage(with: .facebookLoginFailed(error: error))
            }
        }
    }
}
