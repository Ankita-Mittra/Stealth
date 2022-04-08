//
//  ImportWalletViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class ImportWalletViewController: BaseViewController {
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Import Wallet"
//        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    
    func initialSetup(){

    }
    
    // MARK: - Button Actions
    
    @IBAction func submitBtnAction(_ sender: Any) {
//        let navController:UINavigationController = (appDelegate.window?.rootViewController as? UINavigationController)!
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.privateTabBarController.rawValue, bundle: nil)
//        let loginVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateModeTabBar .rawValue) as! PrivateModeTabBarViewController
//        navController.pushViewController(loginVcObj, animated: true)
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar .rawValue) as? PublicModeTabBarViewController
                    self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
    

}
