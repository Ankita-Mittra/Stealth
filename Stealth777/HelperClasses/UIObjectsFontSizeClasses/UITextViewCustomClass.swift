//
//  UITextViewCustomClass.swift
//  Meem
//
//  Created by Developer on 10/22/19.
//  Copyright © 2019 owt. All rights reserved.
//

import UIKit

// UITextView Custom class
@IBDesignable class UITextViewCustomClass: UITextViewFontSize {
    
    // Set inset of UITextField placeholder
    @IBInspectable var horizontalInset: CGFloat = 0
    
    // Set corner radius of UITextField
    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    // Set border width of UITextField
    
    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    // Set border color of UITextField
    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
}
