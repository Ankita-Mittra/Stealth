//
//  AllGroupsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class AllGroupsViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var groupsListTableView: UITableView!
    @IBOutlet weak var segmentedBar: UISegmentedControl!

    // MARK: - View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSmallHeaderAndHideLargeHeader(header: "Group")
        self.navigationItem.largeTitleDisplayMode = .never
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.setRightBarButton(add, animated: true)
    }
    
    // MARK: - Methods

    func initialUISetup(){
        self.groupsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
        
        segmentedBar.setTitle("Owner", forSegmentAt: 0)
        segmentedBar.setTitle("Admin", forSegmentAt: 1)
        segmentedBar.setTitle("Member", forSegmentAt: 2)
    }

    @objc func addTapped(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allContactsList.rawValue) as? AllContactsListViewController
        otherController?.isCreateGroup = true
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
}



extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let chatCell = self.groupsListTableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier , for: indexPath) as? ContactsListTableViewCell else {
            return cell
        }
        
        chatCell.forwardIconImgView.isHidden = false
        return chatCell
    }

}

