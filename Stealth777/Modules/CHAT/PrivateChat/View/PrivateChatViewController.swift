//
//  PrivateChatViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class PrivateChatViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var chatTableView: UITableView!

    var messagesList = [UserModel]()
    
    // MARK: - Injection

    let viewModel = PrivateChatViewModel(apiService: ChatAPIServices())
    
    // MARK: - View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        

        self.navigationItem.largeTitleDisplayMode = .never

//        self.navigationItem.titleView = setTitle(title: "Username", subtitle: "status")
        
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.setSmallHeaderAndHideLargeHeader(header: "private chat")

    }

    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//
    // MARK: - Methods

    func initialUISetup(){
        self.chatTableView.register(PrivateChatSenderTableViewCell.nib(), forCellReuseIdentifier: PrivateChatSenderTableViewCell.identifier)
        self.chatTableView.register(PrivateChatReceiverTableViewCell.nib(), forCellReuseIdentifier: PrivateChatReceiverTableViewCell.identifier)

        self.chatTableView.rowHeight = UITableView.automaticDimension
        self.chatTableView.estimatedRowHeight = 100
    }
    
    // MARK: - Networking
    
    private func fetchContactsList() {
        
        self.activityIndicatorStart()
        viewModel.getMessages(userID: "")
        viewModel.showAlertClosure = {
            
            print("showAlertClosure")

            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            
            print("didFinishFetch.....")
            
            // stop indicator loader
            self.activityIndicatorStop()
            // reload table
            
                // save users locally
            self.messagesList = self.viewModel.messagesList ?? []
            
            self.chatTableView.reloadData()
        }
    }
    
    // MARK: - UI Setup
    
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        // ...
        print("start")
        
        appDelegate.showProgressHUD(view: self.view)
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        // ...
        appDelegate.hideProgressHUD(view: self.view)
        print("stop")
    }


}



extension PrivateChatViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if indexPath.row == 1{
            guard  let chatCell = self.chatTableView.dequeueReusableCell(withIdentifier: PrivateChatSenderTableViewCell.identifier , for: indexPath) as? PrivateChatSenderTableViewCell else {
                return cell
            }
            return chatCell
        }else{
            guard  let chatCell = self.chatTableView.dequeueReusableCell(withIdentifier: PrivateChatReceiverTableViewCell.identifier , for: indexPath) as? PrivateChatReceiverTableViewCell else {
                return cell
            }
            return chatCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.profile.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.otherUserProfile.rawValue) as? OtherUserProfileViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }

}

