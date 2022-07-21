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
    
    var comingFor = Int() // 1: create group, 2: viewMembers , 3: addMembers
    var contactsList = [GroupParticipantsUserModel]()
    var selectedContactsList = [String]()
    var groupId = String()
    var groupMembers = [GroupMembersModel]()
    
    // MARK: - Injection

    let viewModel = AllContactsViewModel(apiService: GroupsAPIServices())

    
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
        switch comingFor {
        case showContacts:
            self.setSmallHeaderAndHideLargeHeader(header: "Contacts")
        case viewMembers:
            self.setSmallHeaderAndHideLargeHeader(header: "Group Members")
        default:
            self.setSmallHeaderAndHideLargeHeader(header: "Add Participants")
            let next = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextBtnAction))
            self.navigationItem.setRightBarButton(next, animated: true)
        }

    }
    
    // MARK: - Methods

    func initialUISetup(){
        
        hideKeyboardWhenTappedAround()
        
        self.contactsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
        
        switch comingFor {
        case createGroup:
            self.fetchContactsFromLocalDB()
        case showContacts:
            self.fetchContactsFromLocalDB()
            
        case viewMembers:

            // get All group Members from server
            self.getAllGroupMembers()

        case addMembers:
            self.fetchContactsFromLocalDB()

        default: // create group , add member
            break
        }
    }
    
    func fetchContactsFromLocalDB(){
        
        self.contactsList = ContactsDatabaseQueries.fetchAllContactsFromLocalDB()
        self.contactsListTableView.reloadData()
    }
    
    @objc func nextBtnAction(){
        
        switch self.comingFor{
        case addMembers:
            
            // call add member Api
            var members = [String]()
            
            for user in self.contactsList{
                if user.isSelected == 1{
                    members.append(user.userId ?? emptyStr)
                }
            }
            self.addMembersInGroup(memberIds: members)
            
        default:
            var selectedUserList = [GroupParticipantsUserModel]()
            for user in self.contactsList{
                if user.isSelected == 1{
                    selectedUserList.append(user)
                }
            }
            let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.createGroup.rawValue) as? CreateGroupViewController
            otherController?.selectedGroupParticipants = selectedUserList
            self.navigationController?.pushViewController(otherController!, animated: true)
        }
    }
    
    // MARK: - Networking
    
    private func getAllGroupMembers(){
        
        self.activityIndicatorStart()

        viewModel.getAllGroupMembers(groupId: self.groupId)
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
            
            self.groupMembers = self.viewModel.groupMembers ?? []
            
            self.contactsListTableView.reloadData()

        }
    }
    
    private func addMembersInGroup(memberIds: [String]){
        
        self.activityIndicatorStart()

        viewModel.addGroupMembers(memberIds: memberIds, groupId: self.groupId)
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

            CommonFxns.showAlert(self, message: "Added successfully", title: "Success")
        }
    }
    
    private func removeMemberFromGroup(userId: String, indexPath: IndexPath){
        
        self.activityIndicatorStart()

        viewModel.removeGroupMember(userId: userId, groupId: self.groupId)
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

            self.groupMembers.remove(at: indexPath.row)
            self.contactsListTableView.deleteRows(at: [indexPath], with: .fade)
            CommonFxns.showAlert(self, message: "Removed successfully", title: "Success")
        }
    }
    
    
    func activityIndicatorStart() {
       appDelegate.showProgressHUD(view: self.view)
   }
   
    func activityIndicatorStop() {
       appDelegate.hideProgressHUD(view: self.view)
   }
   

}


extension AllContactsListViewController: UITableViewDelegate, UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if comingFor == createGroup || comingFor == addMembers{
        return self.contactsList.count

        
    }else{
        return self.groupMembers.count

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

    if comingFor == createGroup || comingFor == addMembers{
        
        let dict = self.contactsList[indexPath.row]
        userCell.usernameLbl.text = dict.username
        userCell.selectUserBtn.isHidden = false
        switch dict.isSelected {
        case 1:
            userCell.selectUserBtn.setBackgroundImage(UIImage(named: "blueTickCheckbox"), for: .normal)
        default:
            userCell.selectUserBtn.setBackgroundImage(UIImage(named: "grayBorderCheckbox"), for: .normal)
        }
        return userCell
    }else{
        userCell.selectUserBtn.isHidden = true

        let dict = self.groupMembers[indexPath.row]
        
        print(dict)
        userCell.usernameLbl.text = dict.username
        return userCell
    }
    
 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if comingFor == createGroup || comingFor == addMembers{
            let selectedUser = self.contactsList[indexPath.row]

            switch selectedUser.isSelected {
            case 0:
                let newRow = GroupParticipantsUserModel(userId: selectedUser.userId!, username: selectedUser.username!, userType: selectedUser.userType!, bio: selectedUser.bio!, imageUrl: selectedUser.imageUrl!, isMute: selectedUser.isMute!, isBlock: selectedUser.isBlock!, isPin: selectedUser.isPin!, allowWipeout: selectedUser.allowWipeout!, onlineStatus: selectedUser.onlineStatus!, lastOnlineTime: selectedUser.lastOnlineTime!, wKey: selectedUser.wKey!, relation: friends, publicKey: selectedUser.publicKey!, accountStatus: selectedUser.accountStatus!, isSelected: one)
                self.contactsList[indexPath.row] = newRow
            default:
                let newRow = GroupParticipantsUserModel(userId: selectedUser.userId!, username: selectedUser.username!, userType: selectedUser.userType!, bio: selectedUser.bio!, imageUrl: selectedUser.imageUrl!, isMute: selectedUser.isMute!, isBlock: selectedUser.isBlock!, isPin: selectedUser.isPin!, allowWipeout: selectedUser.allowWipeout!, onlineStatus: selectedUser.onlineStatus!, lastOnlineTime: selectedUser.lastOnlineTime!, wKey: selectedUser.wKey!, relation: friends, publicKey: selectedUser.publicKey!, accountStatus: selectedUser.accountStatus!, isSelected: zero)
                self.contactsList[indexPath.row] = newRow
            }
            self.contactsListTableView.reloadData()
            
        }
 

    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if comingFor == viewMembers{
            if editingStyle == .delete {

                self.removeMemberFromGroup(userId: self.groupMembers[indexPath.row].id ?? emptyStr, indexPath: indexPath)
            }
        }
    }
    
    
    
}


