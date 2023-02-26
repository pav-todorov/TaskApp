//
//  NSLayoutConstraint.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

extension NSLayoutConstraint {
    /// Allows for the storing of a layout constraint, while using it in `NSLayoutConstraint.activate(:_)`.
    ///
    ///         NSLayoutConstraint.activate([
    ///             tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    ///                 .storing(in: &tableViewLeadingConstraint)
    ///         ])
    ///
    public func storing(in container: inout NSLayoutConstraint?) -> NSLayoutConstraint {
        container = self
        return self
    }
}
