//
//  EnterPasswordViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 08/03/2022.
//

import UIKit

class EnterPasswordViewController: BaseViewController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial Setup
        
        self.showNavigationBar()
//        self.setHeader(header: "Create Account")
        
//        self.title = "Create Account"
//        self.navigationController?.navigationBar.tintColor = .green
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = .green
//        
//        
//        self.navigationController?.navigationItem
//        self.initialSetup()
    }
    
//    func initialSetup(){
//        self.navigationController?.title = "Create Account"
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.backItem?.leftBarButtonItem?.tintColor = .blue
//    }
    

    override func willMove(toParent parent: UIViewController?) {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never

//        navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
//        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")
        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.setNavigationBarHidden(true, animated: true)

//        DispatchQueue.main.async {
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//            let backButton = UIBarButtonItem(title: "", style: .plain, target: self.navigationController, action: nil)
//            self.navigationItem.leftBarButtonItem = backButton
//
//            self.navigationItem.hidesBackButton = true
//
//            self.navigationItem.setHidesBackButton(true, animated: true)
//            self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chat")
//            self.setSearchBarOnNavigationBar()
//        }

        
//        self.navigationController?.forceUpdateNavBar()
    }


    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
//
//        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateTabBarController.rawValue, bundle: nil)
//        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateModeTabBar .rawValue) as? PrivateModeTabBarViewController
//                    self.navigationController?.pushViewController(objLocationSearch!, animated: true)
        
        let navController:UINavigationController = (appDelegate.window?.rootViewController as? UINavigationController)!
        let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.privateTabBarController.rawValue, bundle: nil)
        let loginVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateModeTabBar .rawValue) as! PrivateModeTabBarViewController
        navController.pushViewController(loginVcObj, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension UINavigationController {
    func forceUpdateNavBar() {
        DispatchQueue.main.async {
            self.navigationBar.sizeToFit()
        }
      }
}
