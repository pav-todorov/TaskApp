//
//  StartPresenter.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import Foundation

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
        interactor.userDidTapLoginButton(credentials: credentials, presenter: self)
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
}
