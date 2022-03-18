//
//  NotificationsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class NotificationsViewController: BaseViewController {

    
    // MARK: - Properties & Delegates

    @IBOutlet weak var notificationsTableView: UITableView!
    

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialUISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        
//
////        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeBtnAction))
////        let moreOptions = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreBtnAction))
//
//        self.navigationItem.setRightBarButtonItems([readAll], animated: true)
        


        
        self.navigationItem.largeTitleDisplayMode = .never
        self.setSmallHeaderAndHideLargeHeader(header: "Notifications")
    }
    
//    UIAction(title: NSLocalizedString("Rename", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
//    UIAction(title: NSLocalizedString("Duplicate", comment: ""), image: UIImage(systemName: "plus.square.on.square"), handler: menuHandler),
//    UIAction(title: NSLocalizedString("Move", comment: ""), image: UIImage(systemName: "folder"), handler: menuHandler)

    @objc func menuHandler(){
        print("menu")
    }
    
    func initialUISetup(){
        self.notificationsTableView.register(NotificationsTableViewCell.nib(), forCellReuseIdentifier: NotificationsTableViewCell.identifier)

        self.notificationsTableView.rowHeight = UITableView.automaticDimension
        self.notificationsTableView.estimatedRowHeight = 100
    }
    
}

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let chatCell = self.notificationsTableView.dequeueReusableCell(withIdentifier: NotificationsTableViewCell.identifier , for: indexPath) as? NotificationsTableViewCell else {
            return cell
        }
        return chatCell
    }

}
