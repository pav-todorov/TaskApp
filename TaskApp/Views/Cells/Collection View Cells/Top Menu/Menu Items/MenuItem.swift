//
//  MenuItem.swift
//  TaskApp
//
//  Created by Pavel on 25.02.23.
//

import UIKit

class MenuItem: UICollectionViewCell {
    // MARK: Variables
    static let identifier = "MenuItem"
    
    // MARK: Outlets
    @IBOutlet weak private var label : UILabel!
    
    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLabelAppearance()
    }
    
    override var isHighlighted: Bool {
        didSet {
            shouldFocusText(isHighlighted)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            shouldFocusText(isSelected)
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupLabel(with text: String) {
        label.text = text
    }
    
    private func configureLabelAppearance() {
        label.textColor = UIColor(rgb: 0x8A8A8A)
    }
    
    private func shouldFocusText(_ isFocused: Bool) {
        label.textColor = isFocused ? UIColor(rgb: 0x333333) : UIColor(rgb: 0x8A8A8A)
    }
}
