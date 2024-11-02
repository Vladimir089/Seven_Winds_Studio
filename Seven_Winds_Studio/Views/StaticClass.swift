//
//  StaticClass.swift
//  Seven_Winds_Studio
//
//  Created by Владимир Кацап on 02.11.2024.
//

import Foundation
import UIKit

class StaticClass {
    
    static func createTitleLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .figmaBrown
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }
    
    static func createTextField(placeholder: String, isPassword: Bool, delegate: UITextFieldDelegate?) -> UITextField {
        let textField = UITextField()
        textField.delegate = delegate
        textField.layer.cornerRadius = 23.5
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.figmaBrown.cgColor
        textField.layer.borderWidth = 2
        textField.textColor = .subTextBrown
        textField.isSecureTextEntry = isPassword
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftView = view
        textField.leftViewMode = .always
        textField.rightView = view
        textField.rightViewMode = .always
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.subTextBrown]
        )
        
        textField.font = .systemFont(ofSize: 18, weight: .light)
        
        return textField
    }
    
    static func createBrownButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1764705882, blue: 0.1019607843, alpha: 1)
        button.layer.cornerRadius = 23.5
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.figmaLightBrown, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor
        return button
    }
    
    static func isM1Simulator() -> Bool {
           return (TARGET_IPHONE_SIMULATOR & TARGET_CPU_ARM64) != 0
       }
    
}
