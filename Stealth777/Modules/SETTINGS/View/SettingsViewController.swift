//
//  SettingsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class SettingsViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var settingsListTableView: UITableView!

    let settingsListTitleArr = ["Profile", "Account", "General Settings", "About", "Privacy and policies", "Share", "Logout"]
    let settingsListTitleImgArr = ["","settings-account","settings-generalSettings", "settings-about", "settings-privacyPolicy", "settings-about", "settings-logout"]
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.initialSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)

    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        self.navigationItem.largeTitleDisplayMode = .always
        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Settings")
        self.navigationController?.navigationBar.sizeToFit()

    }

    
    // MARK: - Methods


    func initialSetup(){
        self.settingsListTableView.register(SettingsTableViewCell.nib(), forCellReuseIdentifier: SettingsTableViewCell.identifier)

    }
    func enterPasswordAlert(){
        let alertController = UIAlertController(title: "New Folder", message: "name this folder", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Name"
        }


        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            // this code runs when the user hits the "save" button

            let inputName = alertController.textFields![0].text

            print("inputName..", inputName)

        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    

}


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
                settingsCell.titleBgImgView.image = UIImage(named: "privateAvatar")
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
            
        default:
            break
        }

    }

}


