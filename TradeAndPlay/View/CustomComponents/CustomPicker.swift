//
//  CustomPicker.swift
//  TradeAndPlay
//
//  Created by Marwen Haouacine on 17/12/2020.
//

import UIKit

// A custom picker to choose the platform 
class CustomPicker: NibView {
    
    @IBOutlet weak var platformPicker: UIPickerView! {
        didSet {
                platformPicker.setValue(UIColor(named: "DarkBlue"), forKey: "textColor")
        }
    }
    
}
