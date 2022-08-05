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
    @IBOutlet weak var btnBlock:UIButton!
    @IBOutlet weak var muteSwitch:UISwitch!
    @IBOutlet weak var pinSwitch:UISwitch!
    
    var selectedUserID = String()
    var selectedChatID = String()
    var isFromContacts = false
    var selectedUser:UserModel?
    let viewModel = OtherUserProfileViewModel()
    
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
    
    //MARK: - IBActions
    
    @IBAction func actionChat(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateChat.rawValue) as? PrivateChatViewController
        otherController?.otherChatUserId = selectedUserID
        self.navigationController?.pushViewController(otherController!, animated: true)
        
    }
    
    @IBAction func actionBlockUser(){
        viewModel.blockUser(userID: selectedUserID)
        
    }
    
    @IBAction func actionUnfriendUser(){
        viewModel.unfriendUser(userID: selectedUserID)
        
    }
    
    @IBAction func actionPin(){
        let pinValue = (selectedUser?.isPin == 0) ? 1 : 0
        let requestObj = PinUserRequest(pin: pinValue, chatId: selectedChatID, receiverType: 0)
        viewModel.pinUser(param: requestObj.toDictionary())
    }
    
    @IBAction func actionMute(){
        let muteValue = (selectedUser?.isMute == 0) ? 1 : 0
        let requestObj = MuteUserRequest(mute: muteValue, chatId: selectedChatID, receiverType: 0)
        viewModel.muteUser(param: requestObj.toDictionary())
    }
    
    // MARK: - Methods

    func initialUISetup(){
        selectedUser = ContactsDatabaseQueries.getUserByID(userId: self.selectedUserID)
        setupViewModelClosures()
        if isFromContacts{
            chatSettingsView.isHidden = true
        }
        else{
            toChatView.isHidden = true
        }
        lblUserName.text = selectedUser?.username
        lblDescription.text = selectedUser?.bio
        CommonFxns.setImage(imageView: imgUser, urlString: selectedUser?.imageUrl, placeHolder: UIImage(named: "privateAvatar"))
        if selectedUser?.isPin == 1{
            btnBlock.setTitle("Unblock".localized, for: .normal)
        }
        
        if selectedUser?.isPin == 1{
            pinSwitch.setOn(true, animated: false)
        }
        else{
            pinSwitch.setOn(false, animated: false)
        }
        
        if selectedUser?.isMute == 1{
            muteSwitch.setOn(true, animated: false)
        }
        else{
            muteSwitch.setOn(false, animated: false)
            
        }

    }
    
    func setupViewModelClosures(){
        viewModel.didFinishBlock = {
            msg in
            CommonFxns.showAlertWithCompletion(title: AlertMessages.SUCCESS_TITLE, message: msg, vc: self) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        viewModel.didFinishUnfriend = {
            msg in
            CommonFxns.showAlertWithCompletion(title: AlertMessages.SUCCESS_TITLE, message: msg, vc: self) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        viewModel.showAlertClosure = {
            errorMessage in
            CommonFxns.showAlert(self, message: errorMessage, title: AlertMessages.ERROR_TITLE)

            
        }
        
        viewModel.didFinishPin = {
            msg in
            if self.selectedUser?.isPin == 1{
                self.pinSwitch.setOn(false, animated: true)
            }
            else{
                self.pinSwitch.setOn(true, animated: true)
            }
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.SUCCESS_TITLE)
        }
        
        viewModel.didFinishMute = {
            msg in
            if self.selectedUser?.isMute == 1{
                self.muteSwitch.setOn(false, animated: true)
            }
            else{
                self.muteSwitch.setOn(true, animated: true)
            }
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.SUCCESS_TITLE)
            
        }
        
    }
    
    
    
}
