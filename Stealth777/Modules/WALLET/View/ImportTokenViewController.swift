//
//  ImportTokenViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class ImportTokenViewController: BaseViewController {

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

//        self.navigationItem.titleView = setTitle(title: "Username", subtitle: "status")
        
//        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.setSmallHeaderAndHideLargeHeader(header: "Import Token")

    }
    
    // MARK: - Button Actions
    
    @IBAction func importTokenBtnAction(_ sender: Any) {
        

    }


}
