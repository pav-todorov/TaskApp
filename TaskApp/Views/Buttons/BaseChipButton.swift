//
//  BaseChipButton.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class BaseChipButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
        configureBorder()
    }
    
    func configureAppearance() {
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 12
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        backgroundColor = .clear
        tintColor = UIColor(rgb: 0x121212)

        // TODO: Fix
        if let openSans = UIFont(name: "OpenSans", size: 200) {
            titleLabel?.font = UIFontMetrics.default.scaledFont(for: openSans)
        }
        self.configuration = configuration
    }
    
    private func configureBorder() {
        layer.cornerRadius = 24
        layer.borderWidth = 1
        layer.borderColor = UIColor(rgb: 0xE6E6E6).cgColor
    }
}
