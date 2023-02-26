//
//  PrimaryButton.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class PrimaryButton: BaseChipButton {
    override func configureAppearance() {
        super.configureAppearance()
        self.backgroundColor = UIColor(rgb: 0x333333)
        tintColor = .white
    }
}
