//
//  AllContactsListViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 18/03/2022.
//

import UIKit

class AllContactsListViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var contactsListTableView: UITableView!
    
    var isCreateGroup = Bool()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialUISetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)

        self.tabBarController?.tabBar.isHidden = true

//        edgesForExtendedLayout = UIRectEdge.bottom
//        extendedLayoutIncludesOpaqueBars = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never

        // Set screen header
        if self.isCreateGroup{
            self.setSmallHeaderAndHideLargeHeader(header: "Add Participants")
        }else{
            self.setSmallHeaderAndHideLargeHeader(header: "Contacts")
        }
    }
    
    
    // MARK: - Methods

    func initialUISetup(){
        self.contactsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
    }
    
    @objc func cancelBtnAction(){
        
    }
}


extension AllContactsListViewController: UITableViewDelegate, UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 12
}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    guard  let userCell = self.contactsListTableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier , for: indexPath) as? ContactsListTableViewCell else {
        return cell
    }
    
    return userCell
}

}


