//
//  EnterUsernameViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit
import SwiftUI

class EnterUsernameViewController: BaseViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var enterUsernameTxtField: UITextField!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var verifiedUsernameImgView: UIImageView!
    var imagePicker: ImagePicker!

    var signUpDict = [String:Any]()
    var isUsernameVerfied = false
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        self.initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // UI setup
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Create Account"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // UI setup
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Methods for Initial Setup

    // Method for initial Setups
    func initialSetup(){
        self.hideKeyboardWhenTappedAround() // Hide keyboard
        self.imagePicker = ImagePicker(presentationController: self, delegate: self) // Set up Image picker to choose profile image for account.
        self.verifiedUsernameImgView.isHidden = true // Hide verified username image
    }

    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        let username = CommonFxns.trimString(string: enterUsernameTxtField.text ?? emptyStr)
        
        username != emptyStr && CommonFxns.isValidUsername(username: username) ? goToNextScreen(username: username) : CommonFxns.showAlert(self, message: "Please Enter a username to continue.", title: "Alert")
    }
    
    @IBAction func chooseProfileImageBtnAction(_ sender: Any) {
        // Show Image picker
        self.imagePicker.present(from: sender as! UIButton)
    }
    
    // MARK: - Other Methods
    // Methods to go to next screen with entered data by user.
    func goToNextScreen(username: String){
        signUpDict["username"] = username
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.enterPassword.rawValue, bundle: nil)
        let nextVcObj = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.enterPassword .rawValue) as? EnterPasswordViewController
        nextVcObj?.signUpDict = self.signUpDict
        self.navigationController?.pushViewController(nextVcObj!, animated: true)
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
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = CommonFxns.trimString(string: text.replacingCharacters(in: textRange, with: string))
            
            if updatedText != emptyStr && CommonFxns.isValidUsername(username: CommonFxns.trimString(string: updatedText)){
                self.verifiedUsernameImgView.isHidden = false
            }else{
                self.verifiedUsernameImgView.isHidden = true
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
