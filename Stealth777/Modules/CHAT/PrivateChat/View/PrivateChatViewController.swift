//
//  PrivateChatViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class PrivateChatViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var txtMessage: UITextFieldCustomClass!
    
    // sendMessageTxtfield // Lbl// btn// view
    // MARK: - Properties
    var headerView : GroupChatHeaderView?
    let viewModel = PrivateChatViewModel()
    var otherChatUser: UserModel?
    let loggedInUserId = UserDefaultsToStoreUserInfo.getuserID()
    var otherChatUserId = String()
    var imagePicker: ImagePicker!
    var messageType = MessageType.Text

    
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
      
    }
    
    //MARK: - IBActions
    
   
    @IBAction func actionChooseFile(sender:UIButton){
        // Show Image picker
        self.imagePicker.present(from: sender)
        
    }
    
// sendBtnAction
    @IBAction func actionSend(){
        
        let msgToSend = CommonFxns.trimString(string: txtMessage.text ?? "")
        if msgToSend.isEmpty{
            return
        }
//
//
//
//        let encryptedMsg = CommonFxns.encryptMsg(msg: msgToSend, publickey: (otherChatUser?.publicKey)!, privateKey: privateKey)
//        print("encryptedMsg///...", encryptedMsg)
//
        messageType = .Text
        let request = SendMessageRequest(msg: msgToSend, groupId: nil, receiverId: otherChatUserId, senderPbKey: publicKey, mediaId: nil, enKey: "1234", quoteMsgId: nil, msgType: messageType.rawValue)
        viewModel.sendMessage(dict: request.toDictionary())
        
    }
    
    
    // MARK: - Methods
    var (privateKey, publicKey) = (String(), String())
    func initialUISetup(){
        // fetch other chat user info from locally
        self.otherChatUser = ContactsDatabaseQueries.getUserByID(userId: self.otherChatUserId)
        setupNavigationBar()
        self.chatTableView.register(PrivateChatSenderTableViewCell.nib(), forCellReuseIdentifier: PrivateChatSenderTableViewCell.identifier)
        self.chatTableView.register(PrivateChatReceiverTableViewCell.nib(), forCellReuseIdentifier: PrivateChatReceiverTableViewCell.identifier)
        
        self.chatTableView.rowHeight = UITableView.automaticDimension
        self.chatTableView.estimatedRowHeight = 100
        self.imagePicker = ImagePicker(presentationController: self, delegate: self) // Set up Image picker to choose files to upload.
        
        setupViewModelClosures()
        viewModel.getLocalMessages(id: otherChatUserId)
        //API call for get messages from server
        viewModel.getMessages(recieverID: otherChatUserId)
        
        // Method to fetch Private keypair from user defaults
        (privateKey, publicKey) = UserDefaultsToStoreUserInfo.getPrivateKeyPair()
        print("Key pair....", privateKey, publicKey)
    }
    
    func setupNavigationBar(){
        //back buttton
        let backbtn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backbtn.setImage(UIImage(named: "backIcon"), for: .normal)
        backbtn.addTarget(self, action: #selector(actionBack), for: .touchUpInside)
        
        headerView = GroupChatHeaderView(frame: CGRect(x: 0, y: 0, width: 150, height: 35))
        headerView?.lblGroupName.text = otherChatUser?.username?.capitalized
        headerView?.lblDescription.isHidden = true
        CommonFxns.setImage(imageView: headerView!.imgPhoto, urlString: otherChatUser?.imageUrl,placeHolder: UIImage(named: "privateAvatar"))
        
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
        CommonFxns.showAlert(self, message: "Chats".localized, title: "testing chat".localized)
    }
    
    @objc func actionAudioCall(){
    }
    
    @objc func toDetails(){
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.profile.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.otherUserProfile.rawValue) as? OtherUserProfileViewController
        otherController?.selectedUserID = otherChatUserId
        self.navigationController?.pushViewController(otherController!, animated: true)
    
    }
    
    func fetchOtherUserPublicKey(){
        //
    }
    
    // MARK: - Networking
    
    
    private func setupViewModelClosures() {
      
        viewModel.showAlertClosure = {
            error in
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
            
        }
        
        viewModel.didFinishFetch = {
            
            self.chatTableView.reloadData()
        }
       
        viewModel.didFinishSendMessage = {
            self.txtMessage.text = emptyStr
            
        }
        
        viewModel.didFinishUploadFile = {
            mediaID in
            let request = SendMessageRequest(msg: "", groupId: nil, receiverId: self.otherChatUserId, senderPbKey: self.publicKey, mediaId: mediaID, enKey: "1234", quoteMsgId: nil, msgType: self.messageType.rawValue)
            self.viewModel.sendMessage(dict: request.toDictionary())
            
        }
    }
    
   
}


//MARK: - TableView Delegates
extension PrivateChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.messageList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = viewModel.messageList?[indexPath.row]
        if obj?.senderId == self.loggedInUserId{
            let chatCell = self.chatTableView.dequeueReusableCell(withIdentifier: PrivateChatSenderTableViewCell.identifier , for: indexPath) as! PrivateChatSenderTableViewCell
            chatCell.configureCell(obj: obj, privateKey: privateKey)
            return chatCell
        }
        else{
            let chatCell = self.chatTableView.dequeueReusableCell(withIdentifier: PrivateChatReceiverTableViewCell.identifier , for: indexPath) as! PrivateChatReceiverTableViewCell
            chatCell.configureCell(obj: obj, privateKey: privateKey)
            return chatCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let storyBoard = UIStoryboard.init(name: enumStoryBoard.profile.rawValue, bundle: nil)
//        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.otherUserProfile.rawValue) as? OtherUserProfileViewController
//        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
}


//MARK: - ImagePickerDelegate
extension PrivateChatViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if image != nil{
            messageType = .Picture
        
            let file = UploadFile(data: image!.jpegData(compressionQuality: 0.5)!, imageKey: "file", mimeType: "image/jpeg", fileName: "image/jpeg")
            viewModel.uploadFile(file: file)
        }
    }
}

