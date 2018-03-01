//
//  MapCell.swift
//  Geneve
//
//  Created by Clem on 01.03.18.
//

import UIKit

class MapCell: UICollectionViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cornerView: UIView!
    
    override func awakeFromNib() {
        cornerView.clipsToBounds = true
        cornerView.layer.cornerRadius = 15.0
        cornerView.layer.borderWidth = 1
        setupStyle()
    }
    
    override var isSelected: Bool {
        didSet {
            setupStyle()
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            setupStyle()
        }
    }
    
    private func setupStyle() {
        let tintColor = UIColor(red:0.85, green:0.23, blue:0.12, alpha:1.0)
        cornerView.backgroundColor = isSelected || isHighlighted ? tintColor : .clear
        nameLabel.textColor = isSelected || isHighlighted ? .white : tintColor
        cornerView.layer.borderColor = tintColor.cgColor
    }
}
