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
        
        self.fetchContactRequests()
    }
    
    // MARK: - Networking
    
    private func fetchContactRequests() {

        self.activityIndicatorStart()
        viewModel.getContactRequests()

        viewModel.showAlertClosure = {
            self.activityIndicatorStop()

            print("showAlertClosure")
            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            print("didFinishFetch   fetchContactRequests.....")
            
            // stop indicator loader
            self.activityIndicatorStop()
            // reload table
            self.friendRequestsList = self.viewModel.friendRequestsList ?? []
            self.requests = self.friendRequestsList
            self.requestsListTableView.reloadData()
        }
    }
    
    private func fetchGroupInvitations() {

        self.activityIndicatorStart()
        viewModel.getGroupInvitaions()

        viewModel.showAlertClosure = {
            self.activityIndicatorStop()

            print("showAlertClosure")
            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        viewModel.didFinishFetch = {
            
            print("didFinishFetch.....fetchGroupInvitations")
            
            // stop indicator loader
            self.activityIndicatorStop()
            // reload table
            self.groupInvitaionsList = self.viewModel.groupInvitaionsList ?? []
            self.requests = self.groupInvitaionsList
            self.requestsListTableView.reloadData()
        }
    }
    
    private func respondFriendRequest(selectedUser: String, action: Int) {

        self.activityIndicatorStart()
        viewModel.respondFriendRequest(selectedUser: selectedUser, action: action)

        viewModel.showAlertClosure = {
            self.activityIndicatorStop()

            print("showAlertClosure")
            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            print("didFinishFetch   fetchContactRequests.....")
            
            // stop indicator loader
            self.activityIndicatorStop()
            // reload table
            
            action == one ? self.updateUIForAcceptRequest() : self.updateUIForRejectRequest()
        }
    }
    
    private func respondGroupRequest(groupId: String, status: Int) {

        self.activityIndicatorStart()
        viewModel.respondGroupRequest(groupId: groupId, status: status)

        viewModel.showAlertClosure = {
            self.activityIndicatorStop()

            print("showAlertClosure")
            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            print("didFinishFetch   respondGroupRequest.....")
            
            // stop indicator loader
            self.activityIndicatorStop()
            // reload table
            
//            status == one ? self.updateUIForAcceptRequest() : self.updateUIForRejectRequest()
        }
    }
    
    
    func updateUIForAcceptRequest(){
        // 1 update user relation in local DB to friends
        let userId = String()

        if let row = self.friendRequestsList.firstIndex(where: {$0.userId == userId}) {
            
            let foundRow = self.friendRequestsList[row]
            
            let newRow = UserModel(userId: foundRow.userId!, username: foundRow.username!, userType: foundRow.userType!, bio: foundRow.bio!, imageUrl: foundRow.imageUrl!, isMute: foundRow.isMute!, isBlock: foundRow.isBlock!, isPin: foundRow.isPin!, allowWipeout: foundRow.allowWipeout!, onlineStatus: foundRow.onlineStatus!, lastOnlineTime: foundRow.lastOnlineTime!, walletKey: foundRow.walletKey!, relation: friends, publicKey: foundRow.publicKey!, accountStatus: foundRow.accountStatus!)

            self.friendRequestsList[row] = newRow
        }
        self.reloadTableview()
    }
    
    func updateUIForRejectRequest(){
        // 1 update user relation in local DB to No relation
        let userId = String()

        if let row = self.friendRequestsList.firstIndex(where: {$0.userId == userId}) {
            
            let foundRow = self.friendRequestsList[row]
            
            let newRow = UserModel(userId: foundRow.userId!, username: foundRow.username!, userType: foundRow.userType!, bio: foundRow.bio!, imageUrl: foundRow.imageUrl!, isMute: foundRow.isMute!, isBlock: foundRow.isBlock!, isPin: foundRow.isPin!, allowWipeout: foundRow.allowWipeout!, onlineStatus: foundRow.onlineStatus!, lastOnlineTime: foundRow.lastOnlineTime!, walletKey: foundRow.walletKey!, relation: noRelation, publicKey: foundRow.publicKey!, accountStatus: foundRow.accountStatus!)

            self.friendRequestsList[row] = newRow
        }
        self.reloadTableview()
    }
    
    func reloadTableview(){
        // get list from local and update UI accordingly
        // reload tableView
        self.requestsListTableView.reloadData()
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

    var firstTime = true
    
    @IBAction func segmentedBarAction(_ sender: UISegmentedControl){
 
        switch sender.selectedSegmentIndex {
        case zero:
            self.requests = self.friendRequestsList
        default:
            
            if firstTime{
                self.fetchGroupInvitations()
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
                
                self.respondFriendRequest(selectedUser: selectedUserId, action: acceptFriendRequest)
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
                
                self.respondFriendRequest(selectedUser: selectedUserId, action: rejectFriendRequest)
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

