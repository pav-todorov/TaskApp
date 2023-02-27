//
//  UserTableViewCell.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class UserTableViewCell: BaseCredentialsTableViewCell {
    // MARK: Variables
    static let identifier = "UserTableViewCell"
    private typealias LocStrings = LocalizedStrings.Views.CredentialsCells.UserCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureText()
    }
    
    private func configureText() {
        configureInputTitleText(with: LocStrings.user_cell_title)
        configureInputFieldPlaceholder(with: LocStrings.user_cell_placeholder)
        configureAssistiveText(with: LocStrings.user_cell_assistive_text)
    }
}
