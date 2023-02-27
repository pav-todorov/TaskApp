//
//  PasswordTableViewCell.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class PasswordTableViewCell: BaseCredentialsTableViewCell {
    // MARK: Subviews
    private lazy var visibilityButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        button.setImage(.init(named: "visibility"), for: .normal)
        button.configuration = configuration
        button.addTarget(self,
                         action: #selector(showHidePasswordField),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: Variables
    static let identifier = "PasswordTableViewCell"
    private typealias LocStrings = LocalizedStrings.Views.CredentialsCells.PasswordCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureTexts()
        configureAccessoryView()
        userInputTextField.isSecureTextEntry = true
    }
    
    private func configureTexts() {
        configureInputTitleText(with: LocStrings.password_cell_title)
        configureInputFieldPlaceholder(with: LocStrings.password_cell_placeholder)
        configureAssistiveText(with: LocStrings.password_cell_assistive_text)
    }
    
    private func configureAccessoryView() {
        userInputTextField.rightView = visibilityButton
        userInputTextField.rightViewMode = .always
    }
    
    @objc private func showHidePasswordField() {
        userInputTextField.isSecureTextEntry.toggle()
        
        if userInputTextField.isSecureTextEntry {
            visibilityButton.setImage(.init(named: "visibility"), for: .normal)
        } else {
            visibilityButton.setImage(.init(named: "visibility_off"), for: .normal)
        }
    }
}
