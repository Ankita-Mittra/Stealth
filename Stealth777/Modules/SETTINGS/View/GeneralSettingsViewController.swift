//
//  GeneralSettingsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit


struct AppLanguages {

    let languageName: String
    let languageCode: String
}

class GeneralSettingsViewController: BaseViewController {

    
    // MARK: - Properties & Delegates

    @IBOutlet weak var settingsListTableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!

    @IBOutlet weak var pickerBgView: UIView!
    var selectedLanguage = Int()
    let settingsListTitleArr = ["Notifications", "Dark Theme", "Language"]
    
    let appLanguages: [AppLanguages] = [
        AppLanguages(languageName: enumLanguages.englishLanguage.rawValue, languageCode: enumLanguageCodes.englishLanguage.rawValue),
        AppLanguages(languageName: enumLanguages.arabicLanguage.rawValue, languageCode: enumLanguageCodes.arabicLanguage.rawValue),
        AppLanguages(languageName: enumLanguages.dutch.rawValue, languageCode: enumLanguageCodes.dutch.rawValue),
        AppLanguages(languageName: enumLanguages.simplifiedChinese.rawValue, languageCode: enumLanguageCodes.simplifiedChinese.rawValue),
        AppLanguages(languageName: enumLanguages.french.rawValue, languageCode: enumLanguageCodes.french.rawValue)
    ]

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.pickerBgView.isHidden = true
    }
    
    @IBAction func doneBtnAction(_ sender: Any) {
        self.pickerBgView.isHidden = true
        print("selectedLanguageCode.....", selectedLanguage)
        CommonFxns.switchLanguageAtHomeScreen(selectedLanguageCode: self.appLanguages[selectedLanguage].languageCode)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        self.navigationItem.largeTitleDisplayMode = .never
        self.title = "General *Settings"
    }
    
    // MARK: - Methods

    func initialSetup(){
        self.pickerView.dataSource = self
         self.pickerView.delegate = self
        self.settingsListTableView.register(SettingsOptionsTableViewCell.nib(), forCellReuseIdentifier: SettingsOptionsTableViewCell.identifier)
        
        self.pickerView.reloadAllComponents()

    }
    
    @objc func switchChanged(_ sender : UISwitch!){

          print("table row switch Changed \(sender.tag)")
          print("The switch is \(sender.isOn ? "ON" : "OFF")")
        
        if sender.isOn{
            appDelegate.window?.overrideUserInterfaceStyle = .dark
            userDefault.set("dark" , forKey: USER_DEFAULT_isDarkMode_Key)
        }else{
            appDelegate.window?.overrideUserInterfaceStyle = .light
            userDefault.set("light" , forKey: USER_DEFAULT_isDarkMode_Key)
        }
    }
}


extension GeneralSettingsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.settingsListTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let settingsCell = self.settingsListTableView.dequeueReusableCell(withIdentifier: SettingsOptionsTableViewCell.identifier , for: indexPath) as? SettingsOptionsTableViewCell else {
            return cell
        }
        settingsCell.permissionSwitch.tag = indexPath.row
        switch indexPath.row {
        case 0:
            settingsCell.permissionSwitch.isHidden = true
            settingsCell.forwardIconImgView.isHidden = false
            settingsCell.languageLbl.isHidden = true
        case 1:
            
            if (userDefault.value(forKey: USER_DEFAULT_isDarkMode_Key) as? String == "light"){
                settingsCell.permissionSwitch.isOn = false
            }else{
                settingsCell.permissionSwitch.isOn = true
            }
            settingsCell.permissionSwitch.isHidden = false
            settingsCell.forwardIconImgView.isHidden = true
            settingsCell.languageLbl.isHidden = true
        default:
            settingsCell.permissionSwitch.isHidden = true
            settingsCell.forwardIconImgView.isHidden = false
            settingsCell.languageLbl.isHidden = false
        }
        settingsCell.titleLbl.text = self.settingsListTitleArr[indexPath.row]
        settingsCell.permissionSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        return settingsCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let storyBoard = UIStoryboard.init(name: enumStoryBoard.notifications.rawValue, bundle: nil)
            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.notifications.rawValue) as? NotificationsViewController
            self.navigationController?.pushViewController(otherController!, animated: true)
        case 2:
            
            self.pickerBgView.isHidden = false

        default:
            break
        }

    }


}

extension GeneralSettingsViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.appLanguages.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerView.tag = row
        return self.appLanguages[row].languageName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedLanguage = pickerView.tag
    }

}
