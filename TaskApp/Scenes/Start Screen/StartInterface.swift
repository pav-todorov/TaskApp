//
//  StartInterface.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit
import AuthenticationServices

// MARK: - Start Viewable
protocol StartViewable: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func showLoadingIndicator()
    func showAlertMessage(with alertType: AlertType)
    func dismissLoadingIndicator(completion: @escaping () -> Void)
    func populateCredentials()
}

// MARK: - Start Navigable
protocol StartNavigable where Self: UIViewController {}

// MARK: - Start Presentable
protocol StartPresentable {
    var view: StartViewable { get set }
    func viewDidLoad()
    
    func showLoadingIndicator()
    func showAlertMessage(with alertType: AlertType)
    func dismissLoadingIndicator(completion: @escaping () -> Void)
    
    func userDidTapLoginButton(credentials: (email: String, password: String))
    func userDidTapGuestButton()
    func userDidTapResetButton()
    func userDidTapAppleButton()
    func userDidTapGoogleButton()
    func userDidTapFacebookButton()
    
    func appleLoginSuccess(with authorization: ASAuthorization)
    func appleLoginFailed(with error: Error)
}

// MARK: - Start Routable
protocol StartRoutable {}

// MARK: - Start Interactive
protocol StartInteractive {
    func login(with credentials: (email: String, password: String), presenter: StartPresentable)
    func appleLogin(delegate: StartViewable)
    func googleLogin()
    func facebookLogin()
}
