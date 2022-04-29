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
    
    // MARK: - Injection
    
    let viewModel = EnterUsernameViewModel(apiService: UserAPIServices())
    
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

    // MARK: - Networking
    
    private func verifyUsername(username: String) {
        
        viewModel.verifyUsername(username: username)
    
        viewModel.updateLoadingStatus = {
            print("success....updateLoadingStatus")

            CommonFxns.showAlert(self, message: "username already existed", title: "alert")

//            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            print("showAlertClosure")

            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            print("viewmodel...didFinishFetch")
            self.goToNextScreen(username: username)

        }
    }
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        let username = CommonFxns.trimString(string: enterUsernameTxtField.text ?? emptyStr)
        
        username != emptyStr && CommonFxns.isValidUsername(username: username) ? self.verifyUsername(username: username) : CommonFxns.showAlert(self, message: "Please Enter a username to continue.", title: "Alert")
    }
    
    @IBAction func chooseProfileImageBtnAction(_ sender: Any) {
        // Show Image picker
        self.imagePicker.present(from: sender as! UIButton)
    }
    
    // MARK: - Other Methods
    
    // Methods to go to next screen with entered data by user.
    func goToNextScreen(username: String){
        signUpDict[enumAPIKeysForUser.username_key.rawValue] = username
        signUpDict[enumAPIKeysForUser.walletPhrase.rawValue] = username

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.enterPassword.rawValue, bundle: nil)
        let nextVcObj = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.enterPassword .rawValue) as? EnterPasswordViewController
        nextVcObj?.signUpDict = self.signUpDict
        self.navigationController?.pushViewController(nextVcObj!, animated: true)
    }
    
    
    
    

}

