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
    var contactsList = [GroupParticipantsUserModel]()
    var selectedContactsList = [String]()
    
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
        
        hideKeyboardWhenTappedAround()
        
        self.contactsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
        
        self.contactsList = ContactsDatabaseQueries.fetchAllContactsFromLocalDB()
        self.contactsListTableView.reloadData()
    }
    
    @objc func nextBtnAction(){

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


extension AllContactsListViewController: UITableViewDelegate, UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    if isCreateGroup{
        return self.contactsList.count
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

        let dict = self.contactsList[indexPath.row]
        userCell.usernameLbl.text = dict.username
        switch dict.isSelected {
        case 1:
//            userCell.selectUserBtn.setImage(UIImage(named: "blueTickCheckbox"), for: .normal)
            userCell.selectUserBtn.setBackgroundImage(UIImage(named: "blueTickCheckbox"), for: .normal)
        default:
//            userCell.selectUserBtn.setImage(UIImage(named: "grayBorderCheckbox"), for: .normal)
            userCell.selectUserBtn.setBackgroundImage(UIImage(named: "grayBorderCheckbox"), for: .normal)

        }
    }
    return userCell
 }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedUser = self.contactsList[indexPath.row]
 
        print(indexPath.row)
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


