//
//  UserInfoViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/03/2022.
//

import UIKit

class UserInfoViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never
        // Set screen header
        self.setSmallHeaderAndHideLargeHeader(header: "Info")

    }
    

}
