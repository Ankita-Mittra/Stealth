//
//  EnterPasswordViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 08/03/2022.
//

import UIKit

class EnterPasswordViewController: BaseViewController {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var enterPasswordTxtField: UITextField!
    @IBOutlet weak var confirmPasswordTxtField: UITextField!
    @IBOutlet weak var validPasswordImgView: UIImageView!
    @IBOutlet weak var passwordStrengthLbl: UILabel!
    @IBOutlet weak var hidePasswordBtn: UIButton!

    var signUpDict = [String:Any]()
    var isValidPassword = Bool()
    var hidePwdBtnClicked = true

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial Setup
        
        self.showNavigationBar()
        hideKeyboardWhenTappedAround()
    }

    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Button Actions
    
    var iconClick = true

    @IBAction func nextBtnAction(_ sender: Any) {
        
        let password = CommonFxns.trimString(string: enterPasswordTxtField.text ?? emptyStr)
        let confirmPassword = CommonFxns.trimString(string: confirmPasswordTxtField.text ?? emptyStr)
        
        password != emptyStr && CommonFxns.validateLength(text: password, size: (8,30)) && CommonFxns.isValidPassword(password: password) && password == confirmPassword ? goToNextScreen() : CommonFxns.showAlert(self, message: "Please Enter a valid password to continue.", title: "Alert")
    }
    
    
    @IBAction func showHidePwdBtnAction(_ sender: Any) {

        if hidePwdBtnClicked{
            self.enterPasswordTxtField.isSecureTextEntry = false
            self.hidePasswordBtn.setImage(UIImage(systemName: "eye"), for: .normal)
        }else{
            self.enterPasswordTxtField.isSecureTextEntry = true
            self.hidePasswordBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)

        }
        hidePwdBtnClicked = !hidePwdBtnClicked
    }

    // MARK: - Methods
    
    func goToNextScreen(){
        
        signUpDict[enumAPIKeysForUser.password_key.rawValue] = CommonFxns.trimString(string: enterPasswordTxtField.text ?? emptyStr)

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.createWallet.rawValue, bundle: nil)
        let nextVcObj = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.createWallet .rawValue) as? CreateWalletViewController
        nextVcObj?.signUpDict = self.signUpDict
        self.navigationController?.pushViewController(nextVcObj!, animated: true)
    }

}


//    func initialSetup(){
//        self.navigationController?.title = "Create Account"
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.backItem?.leftBarButtonItem?.tintColor = .blue
//    }
//
//override func viewWillDisappear(_ animated: Bool) {
//    super.viewWillDisappear(animated)
////        self.navigationItem.largeTitleDisplayMode = .automatic
//    navigationController?.setNavigationBarHidden(true, animated: true)
//
//    DispatchQueue.main.async {
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: self.navigationController, action: nil)
//        self.navigationItem.leftBarButtonItem = backButton
//
//        self.navigationItem.hidesBackButton = true
//
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chat")
//        self.setSearchBarOnNavigationBar()
//    }
//    self.navigationController?.forceUpdateNavBar()
//}


//        self.setHeader(header: "Create Account")
        
//        self.title = "Create Account"
//        self.navigationController?.navigationBar.tintColor = .green
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = .green
//
//
//        self.navigationController?.navigationItem
//        self.initialSetup()


//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationItem.largeTitleDisplayMode = .never
//
////        navigationController?.setNavigationBarHidden(true, animated: true)
//        navigationController?.setNavigationBarHidden(false, animated: true)
////        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")
//        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")
//
//    }
