//
//  OtherUserProfileViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 18/03/2022.
//

import UIKit

class OtherUserProfileViewController: BaseViewController {
    
    @IBOutlet weak var imgUser: UIImageViewCustomClass!
    @IBOutlet weak var lblDescription: UILabelCustomClass!
    @IBOutlet weak var lblUserName: UILabelCustomClass!
    @IBOutlet weak var chatSettingsView: UIView!
    @IBOutlet weak var toChatView: UIView!
    
    var selectedUserId = String()
    var isFromContacts = false
    var user:GroupParticipantsUserModel?
    
    // MARK: - Injection
    
    let viewModel = RequestsViewModel(contactApiService: ContactsAPIServices(), groupApiService: GroupsAPIServices())
    
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

        self.navigationItem.largeTitleDisplayMode = .never
        self.setSmallHeaderAndHideLargeHeader(header: "User Details")
        
    }
    
    // MARK: - Methods

    func initialUISetup(){
        if isFromContacts{
            chatSettingsView.isHidden = true
        }
        else{
            toChatView.isHidden = true
        }
        lblUserName.text = user?.username
        lblDescription.text = user?.bio
        CommonFxns.setImage(imageView: imgUser, urlString: user?.imageUrl, placeHolder: UIImage(named: "privateAvatar"))

    }
    
    //MARK: - IBActions
    
    @IBAction func actionChat(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateChat.rawValue) as? PrivateChatViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
        
    }
    
}
