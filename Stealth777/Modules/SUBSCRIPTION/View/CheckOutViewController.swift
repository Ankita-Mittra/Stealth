//
//  CheckOutViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 25/03/2022.
//

import UIKit

class CheckOutViewController: BaseViewController {

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
        self.setSmallHeaderAndHideLargeHeader(header: "Checkout")

        self.navigationItem.largeTitleDisplayMode = .never
    }
    

}
