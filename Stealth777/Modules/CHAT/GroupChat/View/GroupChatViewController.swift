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

//    var groupId = String()
    var groupInfo : GroupsModel!
    var headerView : GroupChatHeaderView?
    
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
        
    }
    
    // MARK: - Methods

    func initialUISetup(){
        self.chatTableView.register(PrivateChatSenderTableViewCell.nib(), forCellReuseIdentifier: PrivateChatSenderTableViewCell.identifier)
        self.chatTableView.register(PrivateChatReceiverTableViewCell.nib(), forCellReuseIdentifier: PrivateChatReceiverTableViewCell.identifier)

        self.chatTableView.rowHeight = UITableView.automaticDimension
        self.chatTableView.estimatedRowHeight = 100
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        //back buttton
        let backbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backbtn.setImage(UIImage(named: "backIcon"), for: .normal)
        backbtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        
        headerView = GroupChatHeaderView(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        headerView?.lblGroupName.text = groupInfo.name
        headerView?.lblDescription.text = groupInfo.description
        CommonFxns.setImage(imageView: headerView!.imgPhoto, urlString: groupInfo.imageUrl)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toDetails))
        headerView?.addGestureRecognizer(tap)
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: backbtn),UIBarButtonItem(customView: headerView!)]
        
        //video call buttton
        let videobtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        videobtn.setImage(UIImage(named: "chatVideoCall"), for: .normal)
        videobtn.addTarget(self, action: #selector(actionVideoCall), for: .touchUpInside)
        
        //Audio call buttton
        let audiobtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        audiobtn.setImage(UIImage(named: "chatVoiceCall"), for: .normal)
        audiobtn.addTarget(self, action: #selector(actionAudioCall), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: videobtn),UIBarButtonItem(customView: audiobtn)]

    }
    
    @objc func actionBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func actionVideoCall(){
    }
    
    @objc func actionAudioCall(){
    }
    
    @objc func toDetails(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupDetails.rawValue) as? GroupDetailsViewController
        otherController?.groupInfo = self.groupInfo
        self.navigationController?.pushViewController(otherController!, animated: true)
        
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
        
        print("didSelectRowAt...", self.groupInfo)
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupDetails.rawValue) as? GroupDetailsViewController
        otherController?.groupInfo = self.groupInfo
        self.navigationController?.pushViewController(otherController!, animated: true)
    }


}

