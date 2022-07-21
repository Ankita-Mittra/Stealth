//
//  LoginViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit
import LocalAuthentication

class LoginViewController: BaseViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var enterPasswordTxtField: UITextField!
    @IBOutlet weak var loginWithFaceIdSwitch: UISwitch!
    
    var isBiometricLogin = Bool()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial UI Setup
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Initial Methods
    
    // Methods to setup initial UI and functionality
    func initialSetup(){
        hideKeyboardWhenTappedAround() // Method to hide keyboard on tap of the screen
    }
    
//    func setStrings(){
//       if LocalizationSystem.sharedInstance.getLanguage() == arabicLanguage {
//           self.titleLbl.font = UIFont(name: arabicFont_Bold, size: self.titleLbl.font!.pointSize)
//           self.newPwdTxtField.font = UIFont(name: arabicFont_Bold, size: self.newPwdTxtField.font!.pointSize)
//           self.newPwdLbl.font = UIFont(name: arabicFont_Medium, size: self.newPwdLbl.font!.pointSize)
//           self.changePwdLbl.font = UIFont(name: arabicFont_Bold, size: self.changePwdLbl.font!.pointSize)
//           self.pwdUpdatedLbl.font = UIFont(name: arabicFont_Bold, size: self.pwdUpdatedLbl.font!.pointSize)
//           self.confirmPwdTxtField.font = UIFont(name: arabicFont_Bold, size: self.confirmPwdTxtField.font!.pointSize)
//           self.confirmPwdLbl.font = UIFont(name: arabicFont_Medium, size: self.confirmPwdLbl.font!.pointSize)
//           self.currentPwdLbl.font = UIFont(name: arabicFont_Medium, size: self.currentPwdLbl.font!.pointSize)
//           self.currentPwdTxtField.font = UIFont(name: arabicFont_Bold, size: self.currentPwdTxtField.font!.pointSize)
//           self.updateBtn.titleLabel?.font = UIFont(name: arabicFont_Bold, size: (self.updateBtn.titleLabel?.font!.pointSize)!)
//           self.alertPopUpLbl.font = UIFont(name: arabicFont_Medium, size: self.alertPopUpLbl.font!.pointSize)
//       }
//               
//       let titleTxt = LocalizationSystem.sharedInstance.localizedStringForKey(key:"settings", comment: "")
//       titleLbl.text = titleTxt
//       titleLbl.attributedText = NSAttributedString(string: titleTxt, attributes: [.kern: -0.44])
//       
//       pwdUpdatedLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"pwd_updation_success", comment: "")
//
//       changePwdLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"change_pwd", comment: "")
//       currentPwdLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"current_pwd", comment: "")
//       newPwdLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"new_pwd", comment: "")
//       confirmPwdLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"confirm_pwd", comment: "")
//       newPwdTxtField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key:"new_pwd", comment: "")
//       currentPwdTxtField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key:"current_pwd", comment: "")
//       confirmPwdTxtField.placeholder = LocalizationSystem.sharedInstance.localizedStringForKey(key:"confirm_pwd", comment: "")
//       
//       let updateBtnTxt = LocalizationSystem.sharedInstance.localizedStringForKey(key: "update_pwd", comment: "")
//       updateBtn.setAttributedTitle(NSAttributedString(string: updateBtnTxt, attributes: [.kern: -0.32]), for: .normal)
//       updateBtn.setTitle(updateBtnTxt, for: .normal)
//       
//       backBtnImg.image = UIImage(named: LocalizationSystem.sharedInstance.localizedStringForKey(key:"GrayBackIcon-\(LocalizationSystem.sharedInstance.getLanguage())", comment: ""))
//   }
   
    // MARK: - Button Actions
    
    @IBAction func loginBtnAction(_ sender: Any) {
        self.enterPasswordToLogin()
    }

    @IBAction func loginWithFaceIdSwitch(_ sender: Any) {
        
        // Get first UISwitch current status.
        let switchBtn = sender as? UISwitch
        let switchStatus:Bool = switchBtn!.isOn
        
        // Change the label text and second UISwitch status accordingly.
        if(switchStatus){

            print("First switch is turned on")
            self.isBiometricLogin = true

            loginWithFaceIdSwitch.setOn(true, animated: true)
            self.biometricLogin()
        }else{
            print("First switch is turned off")
            self.isBiometricLogin = false

            loginWithFaceIdSwitch.setOn(false, animated: true)
            self.enterPasswordToLogin()
        }
    }
    
    // MARK: - Methods

    // Methods to perform biometric login
    func biometricLogin(){

        if isBiometricLogin{
            let context = LAContext()
            var error: NSError?
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                
                let reason = "Log in to your account"
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

                    if success {
                       // Move to the main thread because a state update triggers UI changes.
                        DispatchQueue.main.async { [unowned self] in
                            
                            self.goToHomeScreen()
                        }

                    } else {
                        print(error?.localizedDescription ?? "Failed to authenticate")
                        DispatchQueue.main.async { [unowned self] in
                            self.loginWithFaceIdSwitch.setOn(false, animated: true)
                        }
//                        CommonFxns.showAlert(self, message: "Enter password for login.", title: "Alert")
                    }
                }
            }
    }else{
            CommonFxns.showAlert(self, message: "Enter password for login.", title: "Alert")
        }
    }
    
    // Method to perform manual login
    func enterPasswordToLogin(){
        if !isBiometricLogin{

            if self.enterPasswordTxtField.text != emptyStr{
                self.goToHomeScreen()
            }else{
                CommonFxns.showAlert(self, message: "Enter valid password", title: "Alert")

            }
        }else{
            CommonFxns.showAlert(self, message: "Biometric Login", title: "Alert")
        }
    }
    
    // Methods to show Home Screen
    func goToHomeScreen(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar .rawValue) as? PublicModeTabBarViewController
        self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }

}
