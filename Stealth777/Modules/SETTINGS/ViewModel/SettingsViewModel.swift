//
//  SettingsViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 31/03/2022.
//

import UIKit
import SwiftUI

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.settingsListTitleArr.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 100
        default:
            return 60
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let settingsCell = self.settingsListTableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier , for: indexPath) as? SettingsTableViewCell else {
            return cell
        }
        settingsCell.titleLbl.text = self.settingsListTitleArr[indexPath.row]
        
        if indexPath.row % 2 == 0{
            if indexPath.row == 0{
                settingsCell.titleBgImgView.image = UIImage.init(named:"privateAvatar")  //UIImage(named: "privateAvatar")
                settingsCell.titleBgImgView.backgroundColor = UIColor.clear

            }else{
                settingsCell.titleBgImgView.backgroundColor = UIColor(named: "SecondaryThemeColor")

            }
        }else{
            settingsCell.titleBgImgView.backgroundColor = UIColor(named: "PrimaryThemeColor")

        }
        settingsCell.titleImgView.image = UIImage(named: self.settingsListTitleImgArr[indexPath.row])
        return settingsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
            case 1:
                let storyBoard = UIStoryboard.init(name: enumStoryBoard.settings.rawValue, bundle: nil)
                let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.accountSettings.rawValue) as? AccountSettingsViewController
                self.navigationController?.pushViewController(otherController!, animated: true)
            case 2:
                let storyBoard = UIStoryboard.init(name: enumStoryBoard.settings.rawValue, bundle: nil)
                let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.generalSettings.rawValue) as? GeneralSettingsViewController
                self.navigationController?.pushViewController(otherController!, animated: true)
            case 6:// App lock
                CommonFxns.popToLoginVC()
            case 7:// Logout
                self.showLogoutAlert()
            default:
                break
            }
    }
    

}

