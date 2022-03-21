//
//  GroupChatViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class GroupChatViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var chatTableView: UITableView!

    // MARK: - View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()
    }
    
    
    
    // MARK: - Methods

    func initialUISetup(){
        self.chatTableView.register(PrivateChatSenderTableViewCell.nib(), forCellReuseIdentifier: PrivateChatSenderTableViewCell.identifier)
        self.chatTableView.register(PrivateChatReceiverTableViewCell.nib(), forCellReuseIdentifier: PrivateChatReceiverTableViewCell.identifier)

        self.chatTableView.rowHeight = UITableView.automaticDimension
        self.chatTableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        

        self.navigationItem.largeTitleDisplayMode = .never
        self.setSmallHeaderAndHideLargeHeader(header: "Group chat")

    }

    
}

extension GroupChatViewController: UITableViewDelegate, UITableViewDataSource {

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
        
        print("didSelectRowAt...")
           let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
           let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupDetails.rawValue) as? GroupDetailsViewController
           self.navigationController?.pushViewController(otherController!, animated: true)
    }


}

