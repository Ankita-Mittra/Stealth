//
//  ContactsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 07/03/2022.
//

import UIKit
import SwiftUI

class ContactsViewController: BaseViewController {
    
    // MARK: - Properties & Delegates

    @IBOutlet weak var contactsListTableView: UITableView!

    let viewModel = ContactsViewModel()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {

        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.setRightBarButton(add, animated: true)
        self.title = LocalizationSystem.sharedInstance.localizedStringForKey(key:"contacts", comment: "")

//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Contacts")
        self.setSearchBarOnNavigationBar()
        self.navigationItem.largeTitleDisplayMode = .always
        
//        self.tabBarItem.title = ""

        self.tabBarController?.tabBarItem.title = ""
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.title = "Contacts"
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Contacts")
//
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
//
//        self.navigationItem.setRightBarButton(add, animated: true)
//    }
//

//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        self.title = "Contacts"
//
//        navigationController?.setNavigationBarHidden(false, animated: false)
//
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        self.navigationItem.largeTitleDisplayMode = .always
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Contacts")
//    }
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//    }

    // MARK: - Methods for Initial Setup

    // Method for initial Setups
    func initialSetup(){
        self.registerCustomCells() // Register Cells
        self.setStrings() // Set UI Strings as per the selected language
    }
    
    // Method to register Custom cell xib's
    func registerCustomCells(){
        
        self.contactsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
        self.contactsListTableView.register(ContactsRequestListTableViewCell.nib(), forCellReuseIdentifier: ContactsRequestListTableViewCell.identifier)

        self.contactsListTableView.rowHeight = UITableView.automaticDimension
        self.contactsListTableView.estimatedRowHeight = 100
    }
    
    func setStrings(){
//        self.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"change_pwd", comment: "")
        
    }

    // MARK: - Methods

    // MARK: - Actions
    
    @objc func addTapped(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.searchUsers.rawValue) as? SearchUsersViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    // MARK: - Button Actions

    
}



extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == zero {
            return 2

        }else {
            return 4
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == zero{
            return 60
        }else{
            return 68
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == zero{
            return 0
        }else{
            return 25
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
        headerView.backgroundColor = UIColor.systemGray4
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.textColor = UIColor(named: "subHeadingColor")
        label.font = .systemFont(ofSize: 16)
        headerView.addSubview(label)
        
        if section == 0{
            label.text = emptyStr
        }else{
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"contacts", comment: "")
        }
        
        return headerView
    }
    
//    let tableHeadingsList = ["title": "requests", ""]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        
        switch indexPath.section {
        case 0:
            guard  let requestCell = self.contactsListTableView.dequeueReusableCell(withIdentifier: ContactsRequestListTableViewCell.identifier , for: indexPath) as? ContactsRequestListTableViewCell else {
                return cell
            }
            
            if indexPath.row == 0{
                requestCell.titleLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"requests", comment: "")
                
                requestCell.titleImgView.image = UIImage(named: "friendRequest")

            }else{
                requestCell.titleLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"groups", comment: "")
                requestCell.titleImgView.image = UIImage(named: "groupIcon")
            }
            return requestCell

        default:
            guard  let listCell = self.contactsListTableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier , for: indexPath) as? ContactsListTableViewCell else {
                return cell
            }
            return listCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0{
            
            if indexPath.row == 0{
                let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
                let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.requests.rawValue) as? RequestsViewController
                self.navigationController?.pushViewController(otherController!, animated: true)
            }else{
                let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
                let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allGroups.rawValue) as? AllGroupsViewController
                self.navigationController?.pushViewController(otherController!, animated: true)
            }
        }
    }

}

