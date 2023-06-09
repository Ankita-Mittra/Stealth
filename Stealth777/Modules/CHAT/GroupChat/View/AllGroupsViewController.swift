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

    var ownerInGroupsList = [GroupsModel]()
    var adminInGroupsList = [GroupsModel]()
    var memberInGroupsList = [GroupsModel]()
    var groupsList = [GroupsModel]()
    var refreshControl:UIRefreshControl?
    // MARK: - Injection

    let viewModel = AllGroupsViewModel(apiService: GroupsAPIServices())
    
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
        viewModel.getLocalGroups()
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
        configureRefreshControl()
        self.setupGroupListClosures()
        viewModel.fetchAllGroups()
        
    }
    
    func configureRefreshControl(){
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .clear
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        groupsListTableView.refreshControl = refreshControl
    }
    
    @objc func refresh(){
        viewModel.fetchAllGroups()
        refreshControl?.endRefreshing()
        
    }

    @objc func addTapped(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allContactsList.rawValue) as? AllContactsListViewController
        otherController?.comingFor = createGroup
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    func goToGroupChatScreen(){

    }
    
    // MARK: - Networking
    
    private func setupGroupListClosures() {
    
        viewModel.showAlertClosure = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.ERROR_TITLE)
        }
        
        viewModel.didFinishFetch = {
            
            
            // reload table
            self.ownerInGroupsList.removeAll()
            self.memberInGroupsList.removeAll()
            self.adminInGroupsList.removeAll()
            let groups = self.viewModel.groups ?? []
            for group in groups{
                
                switch group.groupRole {
                case 3:
                    self.ownerInGroupsList.append(group)
                case 2:
                    self.adminInGroupsList.append(group)
                case 1:
                    self.memberInGroupsList.append(group)
                default:
                    print("No group......")
                }
            }
            self.groupsList = self.ownerInGroupsList
            self.groupsListTableView.reloadData()
        }
        
       
        
       
    }
    
  
    @IBAction func groupSegmentedBarAction(_ sender: Any) {
        
        switch self.segmentedBar.selectedSegmentIndex {
        case 0:
            print("owner")
            self.groupsList = self.ownerInGroupsList
        case 1:
            print("admin")
            self.groupsList = self.adminInGroupsList
        case 2:
            print("member")
            self.groupsList = self.memberInGroupsList
        default:
            break
        }
        self.groupsListTableView.reloadData()
    }
    
}


extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return groupsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let groupCell = self.groupsListTableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier , for: indexPath) as? ContactsListTableViewCell else {
            return cell
        }
        
        let dict = self.groupsList[indexPath.row]
        groupCell.usernameLbl.text = dict.name
        print("dict.members...", dict.members)
        groupCell.forwardIconImgView.isHidden = false

        return groupCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedGroupInfo = self.groupsList[indexPath.row]
        
        print("selectedGroupInfo...", selectedGroupInfo)

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
        
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupChat.rawValue) as? GroupChatViewController
        otherController?.groupID = selectedGroupInfo.id
        self.navigationController?.pushViewController(otherController!, animated: true)
    }

}

