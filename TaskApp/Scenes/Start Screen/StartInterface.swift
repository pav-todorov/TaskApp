//
//  StartInterface.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit

// MARK: - Start Viewable
protocol StartViewable: AnyObject {
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
    func userDidTapLoginButton(credentials: (email: String, password: String))
    func showLoadingIndicator()
    func showAlertMessage(with alertType: AlertType)
    func dismissLoadingIndicator(completion: @escaping () -> Void)
    func userDidTapGuestButton()
    func userDidTapResetButton()
}

// MARK: - Start Routable
protocol StartRoutable {}

// MARK: - Start Interactive
protocol StartInteractive {
    func userDidTapLoginButton(credentials: (email: String, password: String), presenter: StartPresentable)
}
