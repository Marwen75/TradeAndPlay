//
//  CustomTextField.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

@IBDesignable
class CustomTextField: NibView {
    
    @IBOutlet weak var gameTextField: UITextField! {
        
        didSet {
            let grayPlaceholderText = NSAttributedString(string: "Enter the name of your game here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            
            gameTextField.attributedPlaceholder = grayPlaceholderText
        }
    }
}
