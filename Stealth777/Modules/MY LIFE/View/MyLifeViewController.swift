//
//  MyLifeViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 30/03/2022.
//

import UIKit

class MyLifeViewController: BaseViewController {

    // MARK: - View life cycle
    
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

        self.navigationItem.largeTitleDisplayMode = .always
        self.title = "My Life"
        self.navigationController?.navigationBar.sizeToFit()
    }
}
