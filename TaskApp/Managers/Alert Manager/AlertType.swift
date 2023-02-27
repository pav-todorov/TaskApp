//
//  AlertType.swift
//  TaskApp
//
//  Created by Pavel on 27.02.23.
//

import Foundation

// MARK: Alert Type
enum AlertType {
    private typealias LocStrings = LocalizedStrings.Alerts
    
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
    case googleLoginWelcome(givenName: String, email: String)
    case googleLoginFailed(error: Error)
    
    var title: String {
        switch self {
        case .internalLoginSuccess:  return LocStrings.alerts_titles_internal_login_success
        case .loginAsGuest: return LocStrings.alerts_titles_login_as_guest
        case .loading: return LocStrings.alerts_titles_loading
        case .wrongCredentials: return LocStrings.alerts_titles_wrong_credentials
        case .serverError: return LocStrings.alerts_titles_server_error
        case .systemError(_): return LocStrings.alerts_titles_system_error
        case .appleLoginWelcome(let givenName, _): return .init(format: LocStrings.alerts_titles_apple_login_welcome, givenName)
        case .appleLoginMissingEmail: return LocStrings.alerts_titles_apple_login_missing_email
        case .facebookLoginWelcome(let givenName, _): return .init(format: LocStrings.alerts_titles_facebook_login_welcome, givenName)
        case .facebookLoginFailed: return LocStrings.alerts_titles_facebook_login_failed
        case .googleLoginWelcome(givenName: let givenName, _): return .init(format: LocStrings.alerts_titles_google_login_welcome, givenName)
        case .googleLoginFailed: return LocStrings.alerts_titles_google_login_failed
        }
    }
    
    var message: String {
        switch self {
        case .internalLoginSuccess: return LocStrings.alerts_messages_internal_login_success
        case .wrongCredentials: return LocStrings.alerts_messages_wrong_credentials
        case .loading: return LocStrings.alerts_messages_loading
        case .loginAsGuest: return LocStrings.alerts_messages_login_as_guest
        case .serverError: return LocStrings.alerts_messages_server_error
        case .systemError(let error): return error.localizedDescription
        case .appleLoginWelcome(_, let email): return .init(format: LocStrings.alerts_messages_apple_login_welcome, email)
        case .appleLoginMissingEmail: return LocStrings.alerts_messages_apple_login_missing_email
        case .facebookLoginWelcome(_, let email): return .init(format: LocStrings.alerts_messages_facebook_login_welcome, email)
        case .facebookLoginFailed(let error): return error.localizedDescription
        case .googleLoginWelcome(_, email: let email): return .init(format: LocStrings.alerts_messages_google_login_welcome, email)
        case .googleLoginFailed(error: let error): return error.localizedDescription
        }
    }
}
