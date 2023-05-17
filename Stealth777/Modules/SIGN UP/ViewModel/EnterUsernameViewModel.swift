//
//  EnterUsernameViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
import UIKit

class EnterUsernameViewModel {
    
    // MARK: - Properties
    private var apiService: UserAPIServices?
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Constructor
    init(apiService: UserAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Network call
    
    func verifyUsername(username: String){

        self.apiService?.verifyUsername(username: username, completion: { data, succeeded, error in
            if succeeded {
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                self.didFinishFetch?()
            } else {
                self.error = error as? Error
                self.isLoading = false
               print("error....", error)
                return 
            }
        })
  }

}

// MARK: - TextField delegates

extension EnterUsernameViewController: UITextFieldDelegate {
    
    // dismissing keyboard on pressing return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        self.verifiedUsernameImgView.isHidden = true
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = CommonFxns.trimString(string: text.replacingCharacters(in: textRange, with: string))
            
            if updatedText != emptyStr && CommonFxns.isValidUsername(username: CommonFxns.trimString(string: updatedText)){
                self.verifiedUsernameImgView.isHidden = false
            }
        }
        return updatedText.count <= 15
    }
}

extension EnterUsernameViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if image != nil{
            self.profileImgView.image = image
        }
    }
}
