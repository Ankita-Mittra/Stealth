//
//  GroupSettingsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class GroupSettingsViewController: BaseViewController {
    // MARK: - Properties & Delegates

    @IBOutlet weak var groupSettingsListTableView: UITableView!
    let groupSettingsListArr = ["Members Can Send Message", "Members Visibility", "Allow to Add Members", "Show Group QR", "Joining Approval", "Transfer Ownership (Sell)"]
    
    // MARK: - View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()
    }
    
    
    
    // MARK: - Methods

    func initialUISetup(){
        self.groupSettingsListTableView.register(GroupSettingsTableViewCell.nib(), forCellReuseIdentifier: GroupSettingsTableViewCell.identifier)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        self.navigationItem.largeTitleDisplayMode = .never
        self.setSmallHeaderAndHideLargeHeader(header: "Group Settings")
    }


}

extension GroupSettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupSettingsListArr.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let groupSettingsListCell = self.groupSettingsListTableView.dequeueReusableCell(withIdentifier: GroupSettingsTableViewCell.identifier , for: indexPath) as? GroupSettingsTableViewCell else {
            return cell
        }
        
        groupSettingsListCell.titleLbl.text = self.groupSettingsListArr[indexPath.row]
        
        if indexPath.row == self.groupSettingsListArr.count-1{
            groupSettingsListCell.forwardIconImgView.isHidden = false
        }else{
            groupSettingsListCell.onOffSwitch.isHidden = false
        }

        return groupSettingsListCell
    }
    

}
