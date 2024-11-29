//
//  ViewFactory.swift
//  odola-app
//
//  Created by Александр on 09.09.2024.
//

import Foundation
import UIKit

struct ViewFactory {
    
    struct Buttons {
        
        static func main(title: String) -> UIButton {
            let button = UIButton(type: .system)
            button.layer.cornerRadius = 16
            button.setTitle(title, for: .normal)
            button.setBackgroundImage(Asset.gradientButton.image, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = FontFamily.Poppins.semiBold.font(size: 18)
            button.layer.masksToBounds = true
            return button
        }
        
    }
    
    static func stack(_ axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0) -> UIStackView {
        var stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        return stack
    }
    
    static func label(font: UIFont, color: UIColor) -> UILabel {
        var label = UILabel()
        label.font = font
        label.textColor = color
        return label
    }
    
}
