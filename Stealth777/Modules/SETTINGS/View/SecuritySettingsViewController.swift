//
//  SecuritySettingsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class SecuritySettingsViewController: BaseViewController {
    
    // MARK: - Properties & Delegates

    @IBOutlet weak var settingsListTableView: UITableView!

    let settingsListTitleArr = ["Update Password" ,"Allow Face ID Login", "Reveal Secret Key"]
//    let settingsListTitleImgArr = ["privateAvatar","settings-account","settings-generalSettings", "settings-about", "settings-privacyPolicy", "settings-about", "settings-logout"]
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialSetup()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        self.navigationItem.largeTitleDisplayMode = .never
        self.setSmallHeaderAndHideLargeHeader(header: "Security")
    }
    
    // MARK: - Methods

    func initialSetup(){
        self.settingsListTableView.register(SettingsOptionsTableViewCell.nib(), forCellReuseIdentifier: SettingsOptionsTableViewCell.identifier)

    }
    

}


extension SecuritySettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.settingsListTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let settingsCell = self.settingsListTableView.dequeueReusableCell(withIdentifier: SettingsOptionsTableViewCell.identifier , for: indexPath) as? SettingsOptionsTableViewCell else {
            return cell
        }
        
        switch indexPath.row {
        case 0:
            settingsCell.permissionSwitch.isHidden = true
            settingsCell.forwardIconImgView.isHidden = false

        case 1:
            settingsCell.permissionSwitch.isHidden = false
            settingsCell.forwardIconImgView.isHidden = true
        default:
            settingsCell.permissionSwitch.isHidden = true
            settingsCell.forwardIconImgView.isHidden = false
            
        }
        settingsCell.titleLbl.text = self.settingsListTitleArr[indexPath.row]
        
        return settingsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        switch indexPath.row {
//        case 1:
//            let storyBoard = UIStoryboard.init(name: enumStoryBoard.settings.rawValue, bundle: nil)
//            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.accountSettings.rawValue) as? SettingsViewController
//            self.navigationController?.pushViewController(otherController!, animated: true)
//        case 2:
//            let storyBoard = UIStoryboard.init(name: enumStoryBoard.settings.rawValue, bundle: nil)
//            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.generalSettings.rawValue) as? GeneralSettingsViewController
//            self.navigationController?.pushViewController(otherController!, animated: true)
//
//        default:
//            break
//        }

    }

}


