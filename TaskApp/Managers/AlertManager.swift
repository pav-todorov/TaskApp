//
//  AlertManager.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    // MARK: Initializers
    private init() {}
    
    
    func alert(onBehalfOf uiViewController: UIViewController,
                               with alertType: AlertType) {
        uiViewController.alert(message: alertType.message, title: alertType.title)
    }
    
    func loadingAlert(from uiViewController: UIViewController) {
        uiViewController.showLoadingIndicator(with: AlertType.loading.message)
    }
    
    func dismissLoadingIndicator(onBehalfOf uiViewController: UIViewController, completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            uiViewController.dismiss(animated: true, completion: completion)
        }
    }
}

enum AlertType {
    case internalLoginSuccess
    case loginAsGuest
    case loading
    case wrongCredentials
    case serverError
    case systemError(_ error: Error)
    case appleLoginWelcome(givenName: String, email: String)
    case appleLoginMissingEmail
    case facebookLoginWelcome(givenName: String, email: String)
    case facebookLoginFailed(error: Error)
    
    var title: String {
        switch self {
        case .internalLoginSuccess:  return "Successful Log in"
        case .loginAsGuest: return "Log in as Guest"
        case .loading: return ""
        case .wrongCredentials: return "Login Failed"
        case .serverError: return "Oops"
        case .systemError(_): return "Something Went Wrong"
        case .appleLoginWelcome(let givenName, _): return "Welcome, \(givenName)"
        case .appleLoginMissingEmail: return "Missing Email Address"
        case .facebookLoginWelcome(let givenName, _): return "Welcome, \(givenName)"
        case .facebookLoginFailed: return ""
        }
    }
    
    var message: String {
        switch self {
        case .internalLoginSuccess: return "You were successfully logged in!"
        case .wrongCredentials: return "Your email or password is incorrect.\nPlease, try again."
        case .loading: return "Please, wait..."
        case .loginAsGuest: return "You were successfully logged in as a guest."
        case .serverError:
            return "The server encountered an internal error and was unable to complete your request.\nPlease, try again later."
        case .systemError(let error): return error.localizedDescription
        case .appleLoginWelcome(_, let email): return "You've been successfully logged in with your AppleID: \(email)."
        case .appleLoginMissingEmail: return "A valid email address is required to log in."
        case .facebookLoginWelcome(_, let email): return "You've been successfully logged in with your Facebook account: \(email)."
        case .facebookLoginFailed(let error): return "\(error.localizedDescription)"
        }
    }
}
