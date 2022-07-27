//
//  GroupDetailsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class GroupDetailsViewController: UIViewController, AddParticipantsTableViewCellProtocol {
    
    
    // MARK: - Properties & Outlets

    @IBOutlet weak var groupDetailsListTableView: UITableView!

    var groupInfo : GroupsModel!

    var ownerAndAdminArr = [String]()
    var settingsArr = [String]()
    var controlsArr = [String]()
    let viewModel = GroupDetailsViewModel()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()
    }
    // MARK: - Methods

    func initialUISetup(){
        // register tableView cells
        self.groupDetailsListTableView.register(GroupControlsListTableViewCell.nib(), forCellReuseIdentifier: GroupControlsListTableViewCell.identifier)

        self.groupDetailsListTableView.register(GroupSettingsTableViewCell.nib(), forCellReuseIdentifier: GroupSettingsTableViewCell.identifier)
        self.groupDetailsListTableView.register(ContactsListTableViewCell.nib(), forCellReuseIdentifier: ContactsListTableViewCell.identifier)
        // register tableView headers

        self.groupDetailsListTableView.register(AddParticipantsTableViewCell.nib(), forHeaderFooterViewReuseIdentifier: AddParticipantsTableViewCell.identifier)

        self.groupDetailsListTableView.register(GroupInfoHeaderTableViewCell.nib(), forHeaderFooterViewReuseIdentifier: GroupInfoHeaderTableViewCell.identifier)
        
        ownerAndAdminArr = ["Owner", "Admin", "Admin", ""]
        settingsArr = ["Group Settings", "Mute Chat", "Pin Chat"]
        
        if groupInfo.groupRole == 3{
            controlsArr = ["Report Group", "Clear Chat History", "Delete Group"]
        }else{
            controlsArr = ["Report Group", "Clear Chat History", "Exit Group"]
        }
    }
    
    // MARK: - Actions

    func viewAllMembersBtnSelected(cell: AddParticipantsTableViewCell) {
        print("view all members...")
        self.goToContactsScreen(comingFor: viewMembers)
    }
    
    func addParticipantsBtnSelected(cell: AddParticipantsTableViewCell) {
        print("add participants...")
        self.goToContactsScreen(comingFor: addMembers)
    }
    
    func goToContactsScreen(comingFor: Int){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allContactsList.rawValue) as? AllContactsListViewController
        
        otherController?.groupId = self.groupInfo.id ?? emptyStr
        otherController?.comingFor  = comingFor
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    func callGroupDeletion(){
        
        viewModel.updateLoadingStatus = {
            print("updateLoadingStatus")

            self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            error in
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
        }
        viewModel.didFinishAction = {
            msg in
            CommonFxns.showAlertWithCompletion(title: AlertMessages.SUCCESS_TITLE, message: msg, vc: self) {
                guard let vc = self.navigationController?.viewControllers.filter({$0 is AllGroupsViewController}).first else{return}
                self.dismiss(animated: false) {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
        viewModel.callDeleteGroup(id: self.groupInfo.id ?? "")
    }
    
    func callExitGroup(){
        
        viewModel.updateLoadingStatus = {
            print("updateLoadingStatus")

            self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            error in
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
        }
        viewModel.didFinishAction = {
            msg in
            CommonFxns.showAlertWithCompletion(title: AlertMessages.SUCCESS_TITLE, message: msg, vc: self) {
                guard let vc = self.navigationController?.viewControllers.filter({$0 is AllGroupsViewController}).first else{return}
                self.dismiss(animated: false) {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
        viewModel.callExitGroup(id: self.groupInfo.id ?? "")
    }


}

// MARK: - UI Setup
extension GroupDetailsViewController{

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
}


extension GroupDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return self.groupInfo.members?.count ?? zero
        case 2:
            return settingsArr.count
        case 3:
            return controlsArr.count
        default:
            return zero
        }
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 66
        case 2:
            return 60
        default:
            return 49
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        switch indexPath.section {
        case 1:
            
            guard  let memberCell = self.groupDetailsListTableView.dequeueReusableCell(withIdentifier: ContactsListTableViewCell.identifier , for: indexPath) as? ContactsListTableViewCell else {
                return cell
            }
            
            memberCell.userStatusLbl.isHidden = false
            memberCell.forwardIconImgView.isHidden = false

            let dict = self.groupInfo.members?[indexPath.row]
            memberCell.usernameLbl.text = dict?.username
            switch dict?.groupRole {
            case 3:
                memberCell.userStatusLbl.text = "Owner"
            case 2:
                memberCell.userStatusLbl.text = "Admin"
            default:
                memberCell.userStatusLbl.text = emptyStr
            }
            return memberCell
            
        case 2:
            
            guard  let settingsListCell = self.groupDetailsListTableView.dequeueReusableCell(withIdentifier: GroupSettingsTableViewCell.identifier , for: indexPath) as? GroupSettingsTableViewCell else {
                return cell
            }
            settingsListCell.titleLbl.text = self.settingsArr[indexPath.row]
            if indexPath.row == 0{
                settingsListCell.forwardIconImgView.isHidden = false
            }else{
                settingsListCell.onOffSwitch.isHidden = false
            }
            return settingsListCell
        default:
            
            guard  let controlsListCell = self.groupDetailsListTableView.dequeueReusableCell(withIdentifier: GroupControlsListTableViewCell.identifier , for: indexPath) as? GroupControlsListTableViewCell else {
                return cell
            }
            controlsListCell.titleLbl.text = self.controlsArr[indexPath.row]
            return controlsListCell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 314
        case 1:
            return 66
        default:
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        switch section {
        case 0:
            let cell = UITableViewHeaderFooterView()
            
            guard  let headerView = self.groupDetailsListTableView.dequeueReusableHeaderFooterView(withIdentifier: GroupInfoHeaderTableViewCell.identifier) as? GroupInfoHeaderTableViewCell else {
                
                return cell
            }
            headerView.groupNameLbl.text = self.groupInfo.name
            headerView.groupDescLbl.text = self.groupInfo.description
            return headerView
        case 1:
            let cell = UITableViewHeaderFooterView()
            
            guard  let headerView = self.groupDetailsListTableView.dequeueReusableHeaderFooterView(withIdentifier: AddParticipantsTableViewCell.identifier) as? AddParticipantsTableViewCell else {
                
                return cell
            }
            headerView.delegate = self
            return headerView
        default:
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
            headerView.backgroundColor = UIColor.clear
            
            
//            let label = UILabel()
//            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
//            label.textColor = UIColor.lightGray
//            label.font = .systemFont(ofSize: 16)
//            label.textColor = .darkGray
//            headerView.addSubview(label)
//
//            if section == 1{
//                label.text = "members"
//            }else{
//                label.text = "Contacts"
//            }
            return headerView
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 3:
        
            if indexPath.row == 2{
                if groupInfo.groupRole == 3{
                print("delete....")
                CommonFxns.showConfirmationAlert(title: AlertMessages.ALERT_TITLE, message: AlertMessages.DELETE_GROUP_MESSAGE, okTitle: AlertMessages.ALERT_YES, cancelTitle: AlertMessages.ALERT_NO, vc: self) {
                    self.callGroupDeletion()
                }
                }
                else{
                    print("Exit")
                    CommonFxns.showConfirmationAlert(title: AlertMessages.ALERT_TITLE, message: AlertMessages.EXIT_GROUP_MESSAGE, okTitle: AlertMessages.ALERT_YES, cancelTitle: AlertMessages.ALERT_NO, vc: self) {
                        self.callExitGroup()
                    }
                }
            }
        case 2:

            if indexPath.row == 0{
                let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
                let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupSettings .rawValue) as? GroupSettingsViewController
                self.navigationController?.pushViewController(objLocationSearch!, animated: true)
            }
        case 1:

            if indexPath.row == 0{
                let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
                let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.userInfo .rawValue) as? UserInfoViewController
                self.navigationController?.pushViewController(objLocationSearch!, animated: true)
            }
        default:
            break
        }

    }
    

}

