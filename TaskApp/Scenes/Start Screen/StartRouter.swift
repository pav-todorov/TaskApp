//
//  StartRouter.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import Foundation

// MARK: - Start Router
final class StartRouter<Navigator>: StartRoutable
    where Navigator: StartNavigable
{
    // MARK: Properties
    private unowned let navigator: Navigator
    
    // MARK: Initializers
    init(navigator: Navigator) {
        self.navigator = navigator
    }
}

