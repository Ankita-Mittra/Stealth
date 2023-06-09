//
//  InitialViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class InitialViewController: BaseViewController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial Setup
        self.hideNavigationBar()
//        self.checkVPNConnectivity()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK: - Methods
    
    func checkVPNConnectivity(){
        if CommonFxns.isVPNActive(){
            CommonFxns.showAlert(self, message: "VPN is connected", title: "Alert")
        }else{
            CommonFxns.showAlert(self, message: "VPN is NOT connected", title: "Alert")
        }
    }

    // MARK: - Button Actions
    
    @IBAction func importWalletBtnAction(_ sender: Any) {

        let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.importWallet.rawValue, bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.importWallet.rawValue) as! ImportWalletViewController
        self.navigationController?.pushViewController(signUpVcObj, animated: true)
    }

    @IBAction func termaAndConditionsBtnAction(_ sender: Any) {

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.main.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.termsAndConditions.rawValue) as? ImportWalletViewController
        self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
    
    @IBAction func createWalletBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.enterUsername.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.enterUsername.rawValue) as? EnterUsernameViewController
        self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
    
}
