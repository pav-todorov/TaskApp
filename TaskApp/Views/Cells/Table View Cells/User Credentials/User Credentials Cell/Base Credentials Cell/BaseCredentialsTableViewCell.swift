//
//  BaseCredentialsTableViewCell.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class BaseCredentialsTableViewCell: UITableViewCell, UITextFieldDelegate {
    // MARK: Variables
    static let id = "BaseCredentialsTableViewCell"
    
    // MARK: Outlets
    @IBOutlet weak var userInputTextField: UITextField!
    @IBOutlet weak private var inputTitle: UILabel!
    @IBOutlet weak private var assistiveText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUserInputTextFieldAppearance()
        userInputTextField.delegate = self
        
        inputTitle.isHidden = true
    }
    
    private func setupUserInputTextFieldAppearance() {
        userInputTextField.backgroundColor = .clear
        userInputTextField.layer.cornerRadius = 5
        userInputTextField.layer.borderWidth = 1
        userInputTextField.layer.borderColor = UIColor(rgb: 0x8A8A8A).cgColor
    }
    
    func configureInputTitleText(with text: String) {
        inputTitle.text = text
    }
    
    func configureAssistiveText(with text: String) {
        assistiveText.text = text
    }
    
    func configureInputFieldPlaceholder(with text: String) {
        userInputTextField.placeholder = text
    }
    
    // MARK: - Text Field Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        userInputTextField.layer.borderColor = UIColor(rgb: 0x333333).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        userInputTextField.layer.borderColor = UIColor(rgb: 0x8A8A8A).cgColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        showHideTitleLabel(textField)
    }
    
    // MARK: - Helper Methods
    func showHideTitleLabel(_ textField: UITextField) {
        textField.text?.isEmpty ?? false ? (inputTitle.isHidden = true) : (inputTitle.isHidden = false)
    }
}
