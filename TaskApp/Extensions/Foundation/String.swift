//
//  String.swift
//  TaskApp
//
//  Created by Pavel on 27.02.23.
//

import Foundation

// MARK: - Localized String
public extension String {
    func localized(for bundleId: Bundle? = nil) -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
