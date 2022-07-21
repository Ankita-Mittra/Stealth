//
//  ContactsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 07/03/2022.
//

import UIKit
import SDWebImage

class ContactsViewController: BaseViewController {
    
    // MARK: - Properties & Delegates

    @IBOutlet weak var contactsListTableView: UITableView!
    @IBOutlet weak var noContactsLbl: UILabel!
    
    var contactsList = [GroupParticipantsUserModel]()
    
    // MARK: - Injection

    let viewModel = ContactsViewModel(apiService: ContactsAPIServices())

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
        self.fetchContactsFromLocalDB()
    }
    
    override func viewDidAppear(_ animated: Bool) {

        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.setRightBarButton(add, animated: true)
        self.title = LocalizationSystem.sharedInstance.localizedStringForKey(key:"contacts", comment: "")

        self.setSearchBarOnNavigationBar()
        self.navigationItem.largeTitleDisplayMode = .always
        
        self.tabBarController?.tabBarItem.title = ""
    }

    // MARK: - Methods

    // Method for initial Setups
    func initialSetup(){
        self.registerCustomCells() // Register Cells
        self.setStrings() // Set UI Strings as per the selected language
        
         //API call to fetch contacts
        //self.fetchContactsList()


    }
    
    // Method to register Custom cell xib's
    func registerCustomCells(){
        
        self.contactsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
        self.contactsListTableView.register(ContactsRequestListTableViewCell.nib(), forCellReuseIdentifier: ContactsRequestListTableViewCell.identifier)

        self.contactsListTableView.rowHeight = UITableView.automaticDimension
        self.contactsListTableView.estimatedRowHeight = 100
    }
    
    func fetchContactsFromLocalDB(){
        
        self.contactsList = ContactsDatabaseQueries.fetchAllContactsFromLocalDB()
        self.contactsListTableView.reloadData()
    }
    
    
    func setStrings(){
//        self.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"change_pwd", comment: "")
    }
    
    // MARK: - Networking
    
    private func fetchContactsList() {
        
//        appDelegate.showProgressHUD(view: self.view)

        self.activityIndicatorStart()
        viewModel.fetchContacts()
        
//        viewModel.updateLoadingStatus = {
//            print("updateLoadingStatus")
//
//            
//            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
//        }
//        
        viewModel.showAlertClosure = {
            
            print("showAlertClosure")

            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            
            print("didFinishFetch.....")
            
            // stop indicator loader
            self.activityIndicatorStop()
            // reload table
            
                // save users locally
           // self.contactsList = self.viewModel.contactsList ?? []
            
            
            self.contactsListTableView.reloadData()
//            ContactsDatabaseQueries.deleteUserDbData()
            
           // ContactsDatabaseQueries.addAndUpdateContactsInLocalDB(contacts : self.contactsList)
        }
    }
    
    // MARK: - UI Setup
    
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        // ...
        print("start")
        
        appDelegate.showProgressHUD(view: self.view)
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        // ...
        appDelegate.hideProgressHUD(view: self.view)
        print("stop")
    }

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
        
        if section == zero { return two} else {
            if self.contactsList.count == 0{
                self.noContactsLbl.isHidden = false
                self.noContactsLbl.text = "Search user to create new contacts."
            }
            return self.contactsList.count
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == zero{ return 60} else{
            return 68
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == zero{ return 0}  else{
            return 25
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return two
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
        headerView.backgroundColor = UIColor.systemGray4
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.textColor = UIColor(named: "subHeadingColor") ;label.font = .systemFont(ofSize: 16)
        headerView.addSubview(label)
        
        switch section{
        case zero:
            label.text = emptyStr
        default:
            label.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"contacts", comment: "")
        }

        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch indexPath.section {
        case 0:
            guard  let requestCell = self.contactsListTableView.dequeueReusableCell(withIdentifier: ContactsRequestListTableViewCell.identifier , for: indexPath) as? ContactsRequestListTableViewCell else {
                return cell
            }
            
            switch indexPath.row {
            case zero:
                requestCell.titleLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"requests", comment: "")
                requestCell.titleImgView.image = UIImage(named: "friendRequest")
            default:
                requestCell.titleLbl.text = LocalizationSystem.sharedInstance.localizedStringForKey(key:"groups", comment: "")
                requestCell.titleImgView.image = UIImage(named: "groupIcon")
            }
            return requestCell
        default:
            guard  let listCell = self.contactsListTableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier , for: indexPath) as? ContactsListTableViewCell else {
                return cell
            }
            let dict = self.contactsList[indexPath.row]
            listCell.usernameLbl.text = dict.username
//            listCell.userImgView.sd_setImage(with: URL(string: dict.imageUrl ?? ""), placeholderImage: "", options: .allowInvalidSSLCertificates, completed: nil)
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
