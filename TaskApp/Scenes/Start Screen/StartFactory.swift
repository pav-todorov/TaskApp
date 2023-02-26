//
//  StartFactory.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit

class StartFactory {
    // MARK: Initalizers
    private init() {}
    
    // MARK: Factory
    static func `default`() -> StartScreen {
        let viewController: StartScreen = .init()
        
        let router: StartRouter = .init(navigator: viewController)

        let interactor: StartInteractor = .init()

        let presenter: StartPresenter = .init(
            view: viewController,
            router: router,
            interactor: interactor
        )
        
        viewController.presenter = presenter
        
        return viewController
    }
}
