//
//  CustomTextField.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 08/12/2020.
//

import UIKit

// A custom textfield for researching a game or a player to trade with
class CustomTextField: NibView {
    
    @IBOutlet weak var gameTextField: UITextField! {
        
        didSet {
            let grayPlaceholderText = NSAttributedString(string: "Enter your text here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
            
            gameTextField.attributedPlaceholder = grayPlaceholderText
        }
    }
}
