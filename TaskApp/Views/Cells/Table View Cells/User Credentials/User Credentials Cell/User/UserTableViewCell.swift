//
//  UserTableViewCell.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class UserTableViewCell: BaseCredentialsTableViewCell {
    static let identifier = "UserTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureInputTitleText(with: "Email")
        configureInputFieldPlaceholder(with: "Email")
        configureAssistiveText(with: "Activated")
    }
}
