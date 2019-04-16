//
//  TextFieldDelegate.swift
//  MemeMe1.0
//
//  Created by Yar Sher on 2/5/19.
//  Copyright © 2019 Yar Sher. All rights reserved.
//

import Foundation
import UIKit


class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let textAttributes:[NSAttributedString.Key: Any] = [
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeColor.rawValue): UIColor.black,
        NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white,
        
        NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
       
        NSAttributedString.Key(rawValue: NSAttributedString.Key.strokeWidth.rawValue): -4.0]
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        textField.defaultTextAttributes = textAttributes
        textField.textAlignment = .center
        textField.backgroundColor = .clear
        textField.borderStyle = .none
                
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return false
    }
    
    
}
