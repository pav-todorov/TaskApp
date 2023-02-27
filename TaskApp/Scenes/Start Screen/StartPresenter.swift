//
//  StartPresenter.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import Foundation
import AuthenticationServices

// MARK: - Start Presenter
final class StartPresenter<View, Router, Interactor>: StartPresentable
where View: StartViewable,
Router: StartRoutable,
Interactor: StartInteractive
{
    // MARK: Variables
    var view: StartViewable
    private let router: Router
    private let interactor: Interactor
    
    // MARK: Initializers
    init(
        view: View,
        router: Router,
        interactor: Interactor
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: Presentable
    func viewDidLoad() {}
    
    func userDidTapLoginButton(credentials: (email: String, password: String)) {
        interactor.login(with: credentials, presenter: self)
    }
    
    func showLoadingIndicator() {
        view.showLoadingIndicator()
    }
    
    func showAlertMessage(with alertType: AlertType) {
        view.showAlertMessage(with: alertType)
    }
    
    func dismissLoadingIndicator(completion: @escaping () -> Void) {
        view.dismissLoadingIndicator(completion: completion)
    }
    
    func userDidTapGuestButton() {
        view.showAlertMessage(with: .loginAsGuest)
    }
    
    func userDidTapResetButton() {
        view.populateCredentials()
    }
    
    func userDidTapAppleButton() {
        interactor.appleLogin(delegate: view)
    }
    
    func appleLoginSuccess(with authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            guard let email = credentials.email else {
                view.showAlertMessage(with: .appleLoginMissingEmail)
                break
            }
            let firstName = credentials.fullName?.givenName ?? "user"
            
            view.showAlertMessage(with: .appleLoginWelcome(givenName: firstName,
                                                           email: email))
        default: break
        }
    }
    
    func appleLoginFailed(with error: Error) {
        view.showAlertMessage(with: .systemError(error))
    }
    
    func userDidTapGoogleButton() {
        interactor.signInWithGoogle(delegate: view, presenter: self)
    }
    
    func userDidTapFacebookButton() {
        interactor.facebookLogin(delegate: view, presenter: self)
    }
}
