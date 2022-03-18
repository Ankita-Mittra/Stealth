//
//  CreateWalletViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class CreateWalletViewController: UIViewController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never

        navigationController?.setNavigationBarHidden(false, animated: false)
//        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateTabBarController.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateModeTabBar .rawValue) as? PrivateModeTabBarViewController
                    self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
    


}
