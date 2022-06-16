//
//  OtherUserProfileViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 18/03/2022.
//

import UIKit

class OtherUserProfileViewController: BaseViewController {

    var selectedUserId = String()
    
    
    // MARK: - Injection
    
    let viewModel = RequestsViewModel(contactApiService: ContactsAPIServices(), groupApiService: GroupsAPIServices())
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialUISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        self.navigationItem.largeTitleDisplayMode = .never
        self.setSmallHeaderAndHideLargeHeader(header: "User Details")
        
    }
    
    // MARK: - Methods

    func initialUISetup(){

    }

}
