//
//  SignupCell.swift
//  TaskApp
//
//  Created by Pavel on 26.02.23.
//

import UIKit

class SignupCell: UICollectionViewCell {
    // MARK: Variables
    static let identifier = "SignupCell"
    private typealias LocStrings = LocalizedStrings.Views.SignupCell
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLocalizableText()
    }
    
    private func configureLocalizableText() {
        titleLabel.text = LocStrings.signup_cell_title
    }
}
