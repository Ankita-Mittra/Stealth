//
//  LoginViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Button Actions
    
    @IBAction func loginBtnAction(_ sender: Any) {

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateTabBarController.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateModeTabBar .rawValue) as? PrivateModeTabBarViewController
                    self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
    
    @IBOutlet weak var loginWithFaceIdSwitch: UISwitch!

    @IBAction func loginWithFaceIdSwitch(_ sender: Any) {
        
        // Get first UISwitch current status.
        let switchBtn = sender as? UISwitch
        let switchStatus:Bool = switchBtn!.isOn
        
        // Change the label text and second UISwitch status accordingly.
        if(switchStatus){

            print("First switch is turned on")
            loginWithFaceIdSwitch.setOn(false, animated: true)
        }else{
            print("First switch is turned off")

            loginWithFaceIdSwitch.setOn(true, animated: true)
        }
        
    }
    
}
