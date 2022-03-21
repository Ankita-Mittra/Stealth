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
    @IBOutlet weak var groupImgView: UIImageView!

    // MARK: - View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()
    }
    // MARK: - Methods

    func initialUISetup(){
        self.groupDetailsListTableView.register(PrivateChatSenderTableViewCell.nib(), forCellReuseIdentifier: PrivateChatSenderTableViewCell.identifier)
        self.groupDetailsListTableView.register(PrivateChatReceiverTableViewCell.nib(), forCellReuseIdentifier: PrivateChatReceiverTableViewCell.identifier)

        self.groupDetailsListTableView.register(GroupInfoHeaderTableViewCell.nib(), forHeaderFooterViewReuseIdentifier: GroupInfoHeaderTableViewCell.identifier)
        self.setTableviewHeader()
    }
    
    func setTableviewHeader(){
//        groupDetailsListTableView.tableHeaderView = self.groupImgView
    }

}


extension GroupDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.row == 1{
            guard  let chatCell = self.groupDetailsListTableView.dequeueReusableCell(withIdentifier: PrivateChatSenderTableViewCell.identifier , for: indexPath) as? PrivateChatSenderTableViewCell else {
                return cell
            }
            return chatCell
        }else{
            guard  let chatCell = self.groupDetailsListTableView.dequeueReusableCell(withIdentifier: PrivateChatReceiverTableViewCell.identifier , for: indexPath) as? PrivateChatReceiverTableViewCell else {
                return cell
            }
            return chatCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 170
        }else{
            return 30
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let cell = UITableViewHeaderFooterView()
            
            guard  let headerView = self.groupDetailsListTableView.dequeueReusableHeaderFooterView(withIdentifier: GroupInfoHeaderTableViewCell.identifier) as? GroupInfoHeaderTableViewCell else {
                
                return cell
            }
            return headerView

        }else{
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
            headerView.backgroundColor = UIColor.systemGray4
            let label = UILabel()
            label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
            label.textColor = UIColor.lightGray
            label.font = .systemFont(ofSize: 16)
            label.textColor = .darkGray
            headerView.addSubview(label)
    
            if section == 1{
                label.text = "members"
            }else{
                label.text = "Contacts"
            }
            return headerView
        }
    }
    

}

