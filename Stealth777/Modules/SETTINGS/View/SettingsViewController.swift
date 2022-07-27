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

    let settingsListTitleArr = ["Profile", "Account", "General Settings", "About", "Privacy and policies", "Share", "App lock", "Logout"]
    let settingsListTitleImgArr = ["","settings-account","settings-generalSettings", "settings-about", "settings-privacyPolicy", "settings-about", "settings-logout", "settings-logout"]
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // initial setup
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
        
//        self.tabBarController?.tabBar.isHidden = false
//        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {

        self.navigationItem.largeTitleDisplayMode = .never
//        self.setSmallHeaderAndHideLargeHeader(header: "Settings")
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
    
    func showLogoutAlert(){
        CommonFxns.showConfirmationAlert(title: AlertMessages.LOGOUT_TITLE, message: AlertMessages.LOGOUT_MESSAGE,vc: self) {
            CommonFxns.directLogOut()
        }
       
    }

}



