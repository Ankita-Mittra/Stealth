//
//  SearchUsersViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 18/03/2022.
//

import UIKit

class SearchUsersViewController: BaseViewController {

 
    // MARK: - Properties & Delegates

    @IBOutlet weak var searchedUsersListTableView: UITableView!
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        self.initialUISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSmallHeaderAndHideLargeHeader(header: "Search Friends")

        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    
    // MARK: - Methods

    func initialUISetup(){
        self.searchedUsersListTableView.register(GroupRequestsTableViewCell.nib(), forCellReuseIdentifier: GroupRequestsTableViewCell.identifier)
    }

}


extension SearchUsersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let userCell = self.searchedUsersListTableView.dequeueReusableCell(withIdentifier: GroupRequestsTableViewCell.identifier , for: indexPath) as? GroupRequestsTableViewCell else {
            return cell
        }
        userCell.sendRequest.isHidden = false
        
        return userCell
    }

}


