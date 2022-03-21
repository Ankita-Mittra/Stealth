//
//  UILabelFontSize.swift
//  FEATD
//
//  Created by developer on 8/6/18.
//  Copyright © 2018 owt. All rights reserved.
//

import UIKit

// UILabel Custom Font class
class UILabelFontSize: UILabel {
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        changeSize()
    }
    // Change Font size of Label according to Screen size
    fileprivate func changeSize() {
        let currentSize = self.font.pointSize
//        if (UIScreen.main.bounds.height < iPhone_8Plus_Height){
//            self.font = self.font.withSize(currentSize-fontSizeForSmallDevices)
//        }
//        if (UIScreen.main.bounds.height > iPhone_X_Height){
//            self.font = self.font.withSize(currentSize+fontSizeForLargeDevices)
//        }
    }
}
