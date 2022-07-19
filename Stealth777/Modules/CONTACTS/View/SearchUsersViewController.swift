//
//  SearchUsersViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 18/03/2022.
//

import UIKit

class SearchUsersViewController: BaseViewController, UISearchBarDelegate, GroupRequestsTableViewCellProtocol {

 
    // MARK: - Properties & Delegates

    @IBOutlet weak var searchedUsersListTableView: UITableView!
    @IBOutlet weak var noUserFoundLbl: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!

    var searchedUsersList = [UserModel]()
    
    // MARK: - Injection

    let viewModel = SearchUsersViewModel(apiService: UserAPIServices(), contactApiService: ContactsAPIServices())

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
        
        self.searchBar.delegate = self
        self.searchedUsersListTableView.register(GroupRequestsTableViewCell.nib(), forCellReuseIdentifier: GroupRequestsTableViewCell.identifier)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("search bar cancel button", searchBar.text)
        self.searchBar.resignFirstResponder()
        
        if let user = searchBar.text{
            self.getSearchedUserInfo(username: user)
        }
    }
    
    // MARK: - Networking

    private func getSearchedUserInfo(username: String){
        
        self.activityIndicatorStart()

        viewModel.fetchSearchedUsers(username: username)
        viewModel.showAlertClosure = {
            
            print("showAlertClosure...", self.viewModel.error)

            if let error = self.viewModel.error {
                print( "errorlocalizedDescription...", error.localizedDescription)

                CommonFxns.showAlert(self, message: error.localizedDescription, title: "Alert")
            }
            self.activityIndicatorStop()
        }
        viewModel.didFinishFetch = {
            
            print("didFinishFetch.....")
            
            // stop indicator loader
            self.activityIndicatorStop()
                        
            // reload table
            self.searchedUsersList = self.viewModel.searchedUsers ?? []
            self.searchedUsersListTableView.reloadData()
        }
    }
    
    private func sendRequestToSelectedUser(userId: String){
        
        self.activityIndicatorStart()

        viewModel.sendRequest(selectedUser: userId)
        viewModel.showAlertClosure = {
            
            print("showAlertClosure...", self.viewModel.error)
            
            if let error = self.viewModel.error {
                print( "errorlocalizedDescription...", error.localizedDescription)
                CommonFxns.showAlert(self, message: error.localizedDescription, title: "Alert")
            }
            self.activityIndicatorStop()
        }
        
        viewModel.didFinishFetch = {
            
            print("didFinishFetch.....")
            CommonFxns.showAlert(self, message: "Request has been send succeefully", title: "Success")
            
            // stop indicator loader
            self.activityIndicatorStop()
            
            self.updateUIForRequestSent(userId: userId)
        }
    }
    
    func updateUIForRequestSent(userId: String){
        // 1 update user relation in local DB to friends
        let userId = String()

        if let row = self.searchedUsersList.firstIndex(where: {$0.userId == userId}){

            let foundRow = self.searchedUsersList[row]
            
            let newRow = UserModel(userId: foundRow.userId!, username: foundRow.username!, userType: foundRow.userType!, bio: foundRow.bio!, imageUrl: foundRow.imageUrl!, isMute: foundRow.isMute!, isBlock: foundRow.isBlock!, isPin: foundRow.isPin!, allowWipeout: foundRow.allowWipeout!, onlineStatus: foundRow.onlineStatus!, lastOnlineTime: foundRow.lastOnlineTime!, walletKey: foundRow.walletKey!, relation: pendingRequest, publicKey: foundRow.publicKey!, accountStatus: foundRow.accountStatus!)

            self.searchedUsersList[row] = newRow
            
            self.searchedUsersListTableView.reloadData()
        }
    }
    
     func activityIndicatorStart() {
        appDelegate.showProgressHUD(view: self.view)
    }
    
     func activityIndicatorStop() {
        appDelegate.hideProgressHUD(view: self.view)
    }
    
    // MARK: - Custom cell button Actions
    
    func sendRequestBtnSelected(cell: GroupRequestsTableViewCell) {
        
        guard let row = self.searchedUsersListTableView.indexPath(for: cell)?.row else{
            return
        }
        
        let dict = self.searchedUsersList[row]
        self.sendRequestToSelectedUser(userId: dict.userId ?? emptyStr)
        print("sendRequestBtnSelected dict...", dict)

    }
    
    func sendMessageBtnSelected(cell: GroupRequestsTableViewCell) {
        guard let row = self.searchedUsersListTableView.indexPath(for: cell)?.row else{
            return
        }
        let dict = self.searchedUsersList[row]

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.profile.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.otherUserProfile.rawValue) as? OtherUserProfileViewController
        otherController?.selectedUserId = dict.userId ?? emptyStr
        self.navigationController?.pushViewController(otherController!, animated: true)
        print("sendMessageBtnSelected...", dict)
    }

}

extension SearchUsersViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedUsersList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let userCell = self.searchedUsersListTableView.dequeueReusableCell(withIdentifier: GroupRequestsTableViewCell.identifier , for: indexPath) as? GroupRequestsTableViewCell else {
            return cell
        }
        userCell.delegate = self
        let dict = searchedUsersList[indexPath.row]
        userCell.usernameLbl.text = dict.username
        userCell.bioLbl.text = dict.bio
        
        switch dict.relation {
        case 0: // request pending
            userCell.sendRequest.isHidden = false
            
            userCell.requestSent.isHidden = true
            
            userCell.sendMessage.isHidden = true

//            userCell.userna
        case 2:
            userCell.sendMessage.isHidden = false
            
            userCell.requestSent.isHidden = true
            
            userCell.sendRequest.isHidden = true

        case 1:
            userCell.requestSent.isHidden = false
            
            userCell.sendMessage.isHidden = true
            
            userCell.sendRequest.isHidden = true

        default: break
        }
        return userCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("go to selected user profile")
        
        let dict = self.searchedUsersList[indexPath.row]
    }
    
    
    
    

}


