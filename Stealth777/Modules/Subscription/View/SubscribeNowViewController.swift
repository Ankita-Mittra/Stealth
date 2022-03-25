//
//  SubscribeNowViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 25/03/2022.
//

import UIKit

class SubscribeNowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSmallHeaderAndHideLargeHeader(header: "Subscribe Now")

        self.navigationItem.largeTitleDisplayMode = .never
    }
    
}
