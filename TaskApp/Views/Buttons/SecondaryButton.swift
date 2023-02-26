//
//  SecondaryButton.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class SecondaryButton: BaseChipButton {    
    override var isHighlighted: Bool {
        didSet {
            isHighlighted
            ? (self.layer.borderColor = UIColor(rgb: 0x333333).cgColor)
            : (self.layer.borderColor = UIColor(rgb: 0xE6E6E6).cgColor)
        }
    }
}
