//
//  RequestsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/03/2022.
//

import UIKit

class RequestsViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var requestsListTableView: UITableView!
    @IBOutlet weak var segmentedBar: UISegmentedControl!
    
    // MARK: - View life cycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialUISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSmallHeaderAndHideLargeHeader(header: "Requests")

        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Methods

    func initialUISetup(){
        self.requestsListTableView.register(GroupRequestsTableViewCell.nib(), forCellReuseIdentifier: GroupRequestsTableViewCell.identifier)
        
        segmentedBar.setTitle("Friend Requests", forSegmentAt: 0)
        segmentedBar.setTitle("Group Requests", forSegmentAt: 1)
    }
    
    @IBAction func segmentedBarAction(_ sender: UISegmentedControl) {
        
//        switch sender.selectedSegmentIndex {
//        case 0:
//        default:
//        }
        
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

