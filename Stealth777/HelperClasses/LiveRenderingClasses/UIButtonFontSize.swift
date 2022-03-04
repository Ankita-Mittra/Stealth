//
//  UIButtonFontSize.swift
//  FEATD
//
//  Created by developer on 8/6/18.
//  Copyright © 2018 owt. All rights reserved.
//

import UIKit

// UIButton Custom Font class
class UIButtonFontSize: UIButton {

    // MARK: - Methods
    
    override func awakeFromNib() {
        changeSize()
    }
    
    // Change Font size of button according to Screen size
    fileprivate func changeSize() {
        let currentSize = self.titleLabel?.font.pointSize
        let fontDescriptor = self.titleLabel?.font.fontDescriptor
        if (UIScreen.main.bounds.height < iPhone_8Plus_Height){
            self.titleLabel?.font = UIFont(descriptor: fontDescriptor!, size: currentSize!-fontSizeForSmallDevices)
        }
        if (UIScreen.main.bounds.height > iPhone_X_Height){
            self.titleLabel?.font = UIFont(descriptor: fontDescriptor!, size: currentSize!+fontSizeForLargeDevices)
        }
    }

}
