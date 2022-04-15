//
//  EnterPasswordViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 12/04/2022.
//

import Foundation
import UIKit

// MARK: - TextField delegates

extension EnterPasswordViewController: UITextFieldDelegate {
    
    // dismissing keyboard on pressing return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    

//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let updatedText = CommonFxns.trimString(string: textField.text ?? "")
//
//
//        updatedText != emptyStr && CommonFxns.isValidPassword(password: updatedText) && (self.enterPasswordTxtField.text == self.confirmPasswordTxtField.text) ? validInput() : invalidInput()
//
//    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
print("updatedText....", updatedText)
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = CommonFxns.trimString(string: text.replacingCharacters(in: textRange, with: string))
            
            updatedText != emptyStr && CommonFxns.isValidPassword(password: updatedText) && (self.enterPasswordTxtField.text == self.confirmPasswordTxtField.text) ? validInput() : invalidInput()
        }
        return updatedText.count <= 30
    }
    
    func validInput(){
        self.validPasswordImgView.isHidden = false
        self.passwordStrengthLbl.text = "Strong"
    }
    
    func invalidInput(){
        self.validPasswordImgView.isHidden = true
        self.passwordStrengthLbl.text = "Weak"
    }
    
    
    
}
