//
//  StartInteractor.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import Foundation
import UIKit

// MARK: Start Interactor
struct StartInteractor: StartInteractive {
    
    
    // MARK: Start Interactive
    func userDidTapLoginButton(credentials: (email: String, password: String),
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
}
