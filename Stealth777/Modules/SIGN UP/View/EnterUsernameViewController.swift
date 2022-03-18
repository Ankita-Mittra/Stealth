//
//  EnterUsernameViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class EnterUsernameViewController: BaseViewController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()


//        self.setHeader(header: "Create Account")
        // Initial Setup
        
////        self.initialSetup()
//        self.title = "Create Account"
//        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue]

//        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = .green
//
//        self.navigationController?.navigationBar.tintColor = .red
//
//        self.navigationItem.left
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//
////        let barButtonMenu = UIMenu(title: "", children: [
////            UIAction(title: NSLocalizedString("Copy", comment: ""), image: UIImage(systemName: "doc.on.doc"), handler: menuHandler),
////            UIAction(title: NSLocalizedString("Rename", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
////            UIAction(title: NSLocalizedString("Duplicate", comment: ""), image: UIImage(systemName: "plus.square.on.square"), handler: menuHandler),
////            UIAction(title: NSLocalizedString("Move", comment: ""), image: UIImage(systemName: "folder"), handler: menuHandler)
////        ])
////        optionsBarItem.menu = barButtonMenu
//
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
//        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(addTapped))
//
//        navigationItem.rightBarButtonItems = [add, play]
//
//
//
//}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Create Account"
//        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func addTapped(){
        
    }
    
//    func initialSetup(){
//        self.navigationController?.title = "Create Account"
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.backItem?.leftBarButtonItem?.tintColor = .green
//    }
//    
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.enterPassword.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.enterPassword .rawValue) as? EnterPasswordViewController
                    self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
