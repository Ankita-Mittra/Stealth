//
//  RequestsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/03/2022.
//

import UIKit

class RequestsViewController: BaseViewController, GroupRequestsTableViewCellProtocolForRequestActions {

    // MARK: - Properties & Delegates

    @IBOutlet weak var requestsListTableView: UITableView!
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    
    var friendRequestsList = [UserModel]()
    var groupInvitaionsList = [GroupInvitaionsListModel]()
    var requests = [Any]()
    
    // MARK: - Injection
    
    let viewModel = RequestsViewModel(contactApiService: ContactsAPIServices(), groupApiService: GroupsAPIServices())
    
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
        self.setSmallHeaderAndHideLargeHeader(header: "Requests")

        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Methods

    func initialUISetup(){
        
        self.requests = self.friendRequestsList
        self.requestsListTableView.register(GroupRequestsTableViewCell.nib(), forCellReuseIdentifier: GroupRequestsTableViewCell.identifier)
        
        segmentedBar.setTitle("Friend Requests", forSegmentAt: zero)
        segmentedBar.setTitle("Group Requests", forSegmentAt: one)
        
        // API's calls
        setupClosures()
        viewModel.getContactRequests()
        
    }
    
    // MARK: - Networking
    
    func setupClosures(){
        viewModel.showAlertClosure = {
            error in
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
        }
        
        viewModel.didFinishFetchContactRequests = {
            self.friendRequestsList = self.viewModel.friendRequests ?? []
            self.requests = self.friendRequestsList
            self.requestsListTableView.reloadData()
            
        }
        viewModel.didFinishFetchGroupInvitaions = {
            // reload table
            self.groupInvitaionsList = self.viewModel.groupInvitaions ?? []
            self.requests = self.groupInvitaionsList
            self.requestsListTableView.reloadData()
            
        }
        
        viewModel.didFinishRespondFriendRequest = {
            message in
            CommonFxns.showAlertWithCompletion(title: AlertMessages.SUCCESS_TITLE, message: message, vc: self) {
                self.navigationController?.popViewController(animated: true)
                
            }
        }
        
        
    }
    
    
  
    
    private func respondGroupRequest(groupId: String, status: Int) {

        viewModel.didFinishRespondGroupRequest = {
            message in
            CommonFxns.showAlertWithCompletion(title: AlertMessages.SUCCESS_TITLE, message: message, vc: self) {
            }
        }
        viewModel.respondGroupRequest(groupId: groupId, status: status)

       
    }
    
    
    

    // MARK: - Actions

    var firstTime = true
    
    @IBAction func segmentedBarAction(_ sender: UISegmentedControl){
 
        switch sender.selectedSegmentIndex {
        case zero:
            self.requests = self.friendRequestsList
        default:
            
            if firstTime{
                viewModel.getGroupInvitaions()
                firstTime = false
            }
            self.requests = self.groupInvitaionsList
        }

        self.requestsListTableView.reloadData()
    }
    
    func acceptRequest(cell: GroupRequestsTableViewCell) {        
        switch self.segmentedBar.selectedSegmentIndex {
        case zero:
            if let row = self.requestsListTableView.indexPath(for: cell)?.row{
                
                let selectedUserId = self.friendRequestsList[row].userId ?? emptyStr
                print("acceptRequest.....",selectedUserId )
                viewModel.respondFriendRequest(selectedUser: selectedUserId, action: acceptFriendRequest)
                
            }
        default:
            print("group acceptRequest")
            
            if let row = self.requestsListTableView.indexPath(for: cell)?.row{
                
                let selectedGroupId = self.groupInvitaionsList[row].id ?? emptyStr
                print("selectedGroupId.....",selectedGroupId )
                
                self.respondGroupRequest(groupId: selectedGroupId, status: acceptGroupRequest)
            }
        }
    }
    
    func rejectRequest(cell: GroupRequestsTableViewCell) {
  
        switch self.segmentedBar.selectedSegmentIndex {
        case zero:
            if let row = self.requestsListTableView.indexPath(for: cell)?.row{
                let selectedUserId = self.friendRequestsList[row].userId ?? emptyStr
                print("rejectRequest.....",selectedUserId )
                viewModel.respondFriendRequest(selectedUser: selectedUserId, action: rejectFriendRequest)
            }
        default:
            print("group rejectRequest")
            if let row = self.requestsListTableView.indexPath(for: cell)?.row{
                let selectedGroupId = self.groupInvitaionsList[row].id ?? emptyStr
                print("rejectRequest.....", selectedGroupId )
                
                self.respondGroupRequest(groupId: selectedGroupId, status: rejectGroupRequest)
            }
        }
    }
    
}

extension RequestsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.requests.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let requestCell = self.requestsListTableView.dequeueReusableCell(withIdentifier: GroupRequestsTableViewCell.identifier , for: indexPath) as? GroupRequestsTableViewCell else {
            return cell
        }
        requestCell.requestActionDelegates = self
        requestCell.handleRequestView.isHidden = false
        
        switch self.segmentedBar.selectedSegmentIndex {
        case zero:
            if let dict = self.requests[indexPath.row] as? UserModel {
                requestCell.usernameLbl.text = dict.username
            }
        default:
            if let dict = self.requests[indexPath.row] as? GroupInvitaionsListModel {
                
                requestCell.usernameLbl.text = dict.name
                requestCell.bioLbl.text = dict.id
            }
        }
        return requestCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexPath.section == 0{
//            let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
//            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allGroups.rawValue) as? AllGroupsViewController
//            self.navigationController?.pushViewController(otherController!, animated: true)
//        }else{
//            let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
//            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupChat.rawValue) as? GroupChatViewController
//            self.navigationController?.pushViewController(otherController!, animated: true)
//        }
    }
    
    
}

