//
//  AlertManager.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit

class AlertManager {
    // MARK: Variables
    static let shared = AlertManager()
    private typealias LocStrings = LocalizedStrings.Alerts
    
    // MARK: Initializers
    private init() {}
    
    // MARK: Public methods
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
