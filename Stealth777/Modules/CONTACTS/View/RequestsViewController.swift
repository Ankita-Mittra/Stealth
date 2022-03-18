//
//  RequestsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/03/2022.
//

import UIKit

class RequestsViewController: UIViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var requestsListTableView: UITableView!

    
    // MARK: - View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()
    }
    
    // MARK: - Methods

    func initialUISetup(){
        title = "Requests"
        self.requestsListTableView.register(GroupRequestsTableViewCell.nib(), forCellReuseIdentifier: GroupRequestsTableViewCell.identifier)
    }

}



extension RequestsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let requestCell = self.requestsListTableView.dequeueReusableCell(withIdentifier: GroupRequestsTableViewCell.identifier , for: indexPath) as? GroupRequestsTableViewCell else {
            return cell
        }
        
        if indexPath.row == 0{
            requestCell.sendMessage.isHidden = true

            requestCell.handleRequestView.isHidden = false
        }else{
            requestCell.sendMessage.isHidden = false
            
            requestCell.handleRequestView.isHidden = true


        }
        return requestCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        if indexPath.section == 0{
//            let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
//            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allGroups.rawValue) as? AllGroupsViewController
//            self.navigationController?.pushViewController(otherController!, animated: true)
//        }else{
//            let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
//            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupChat.rawValue) as? GroupChatViewController
//            self.navigationController?.pushViewController(otherController!, animated: true)
//        }
    }

}

