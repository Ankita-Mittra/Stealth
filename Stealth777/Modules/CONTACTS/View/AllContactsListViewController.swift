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
        if isCreateGroup{
            self.setSmallHeaderAndHideLargeHeader(header: "Add Participants")
            let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextBtnAction)) //UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(nextBtnAction))
            
            self.navigationItem.setRightBarButton(next, animated: true)
        }else{
            self.setSmallHeaderAndHideLargeHeader(header: "Contacts")
        }


    }
    
    // MARK: - Methods

    func initialUISetup(){
        self.contactsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
    }
    
    @objc func nextBtnAction(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.createGroup.rawValue) as? CreateGroupViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
}


extension AllContactsListViewController: UITableViewDelegate, UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if self.isCreateGroup{
        return 5
    }else{
        return 6
    }
}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    guard  let userCell = self.contactsListTableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier , for: indexPath) as? ContactsListTableViewCell else {
        return cell
    }
    
    if self.isCreateGroup{
        userCell.selectUserBtn.isHidden = false
    }
    
    return userCell
 }

}


