//
//  GroupDetailsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class GroupDetailsViewController: UIViewController {

    
    // MARK: - Properties & Delegates

    @IBOutlet weak var groupDetailsListTableView: UITableView!
    
    let ownerAndAdminArr = ["Owner", "Admin", "Admin", ""]
    let settingsArr = ["Group Settings", "Mute Chat", "Pin Chat"]
    let controlsArr = ["Report Group", "Clear Chat History", "Exit Group"]


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
    }

}


extension GroupDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return ownerAndAdminArr.count
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

            memberCell.userStatusLbl.text = ownerAndAdminArr[indexPath.row]
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
            controlsListCell.titleBtn.setTitle(self.controlsArr[indexPath.row], for: .normal)
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
            return headerView
        case 1:
            let cell = UITableViewHeaderFooterView()
            
            guard  let headerView = self.groupDetailsListTableView.dequeueReusableHeaderFooterView(withIdentifier: AddParticipantsTableViewCell.identifier) as? AddParticipantsTableViewCell else {
                
                return cell
            }
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

