//
//  CreateGroupViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/03/2022.
//

import UIKit

class CreateGroupViewController: BaseViewController {
    
    // MARK: - Outlets & Properties
        
    @IBOutlet weak var groupNameLbl: UITextField!
    @IBOutlet weak var groupImgView: UIImageView!
    @IBOutlet weak var groupDescLbl: UITextView!
    @IBOutlet weak var disperseGroupTimeStatus: UIButton!
    @IBOutlet weak var membersCollectionView: UICollectionView!
    @IBOutlet weak var anonymousSwitch: UISwitch!

    var selectedGroupParticipants = [GroupParticipantsUserModel]()
    var imagePicker: ImagePicker!
    var selectedImage : UIImage!
    var disperseManually = true

    // MARK: - Injection

    let viewModel = CreateGroupViewModel(apiService: GroupsAPIServices())

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSmallHeaderAndHideLargeHeader(header: "Group Details")
        self.navigationItem.largeTitleDisplayMode = .never
        
        let create = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createGroupBtnAction)) //UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(nextBtnAction))
        
        self.navigationItem.setRightBarButton(create, animated: true)
    }

    func initialSetup(){
        hideKeyboardWhenTappedAround()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self) // Set up Image picker to choose profile image for account.

    }
//    override func viewWillLayoutSubviews() {
//        self.membersCollectionView.reloadData()
//    }
    
    // MARK: - Networking
    
    private func createGroup(dict: [String: Any]) {
        
        viewModel.createGroup(parameters: dict)

        viewModel.showAlertClosure = {
            
            print("showAlertClosure")

            if let error = self.viewModel.error {
                print( "error/////", error.localizedDescription)
                CommonFxns.showAlert(self, message: error.localizedDescription, title: "Error")
            }
            
            self.activityIndicatorStop()

        }
        
        viewModel.didFinishFetch = {
            
            print("didFinishFetch.....")
            
            // stop indicator loader
            self.activityIndicatorStop()
            print("createGroup....didFinishFetch")
            
            let groupId = self.viewModel.groupId ?? emptyStr
            let groupName = CommonFxns.trimString(string: self.groupNameLbl.text ?? emptyStr)
            let groupDescription = CommonFxns.trimString(string: self.groupDescLbl.text ?? emptyStr)
            let groupImgUrl = String()
            
            let anonymous = self.anonymousSwitch.isOn ? 1 : 0

            let disperseDate = self.disperseManually ? "" : "date"
            let disperse = self.disperseManually ? 1 : 0
            
            var groupMembers = [GroupMembersModel]()
            
            for user in self.selectedGroupParticipants{
                let member = GroupMembersModel(with: user)
                groupMembers.append(member)
            }
            
            let groupInfo = GroupsModel(id: groupId, name: groupName, description: groupDescription, imageUrl: groupImgUrl, anonymous: anonymous, disperse: disperse, disperseDate: disperseDate, canSendMsg: 1, showQr: 1, isPin: 0, isMute: 0, groupRole: 3, members: groupMembers, thumbUrl: "")
            
            self.showCustomtAlert(groupInfo: groupInfo)
        }
    }
    
    private func uploadGroupImage() {
        let image = self.groupImgView.image
        
        print("image....", image)
        self.activityIndicatorStart()
        viewModel.uploadFile(groupImage: self.selectedImage)

        viewModel.showAlertClosure = {
            
            print("showAlertClosure")

            if let error = self.viewModel.error {
                print( "error/////", error.localizedDescription)
                CommonFxns.showAlert(self, message: error.localizedDescription, title: "Error")
            }
            self.activityIndicatorStop()
        }
        
        viewModel.didFinishFetch = {
            
            print(" uploadGroupImage didFinishFetch.....")
            // stop indicator loader
            self.activityIndicatorStop()

            self.collectParameteresAndCreateGroup(mediaID: self.viewModel.mediaID ?? emptyStr)
        }
    }
    
    //uploadFile
    func showCustomtAlert(groupInfo: GroupsModel){
        let refreshAlert = UIAlertController(title: "Success", message: "Group has been created successfully", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { (action: UIAlertAction!) in
            
            self.goToGroupChatSsreen(groupID: groupInfo.id)
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    // MARK: - UI Setup
    
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        appDelegate.showProgressHUD(view: self.view)
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        appDelegate.hideProgressHUD(view: self.view)
    }
    
    func collectParameteresAndCreateGroup(mediaID: String){
        self.activityIndicatorStart()
        let groupName = CommonFxns.trimString(string: self.groupNameLbl.text ?? emptyStr)
        let groupDescription = CommonFxns.trimString(string: self.groupDescLbl.text ?? emptyStr)
        let anonymous = self.anonymousSwitch.isOn ? 1 : 0
           
        let disperseDate = disperseManually ? "" : "date"
        
        let disperse = disperseManually ? 1 : 0
        var members = [String]()
        
        for user in selectedGroupParticipants{
            if let userId = user.userId{
                members.append(userId)
            }
        }

        let dict = [enumAPIKeysForGroup.groupName_key.rawValue: groupName, enumAPIKeysForGroup.description_key.rawValue: groupDescription, enumAPIKeysForGroup.mediaId_key.rawValue : mediaID, enumAPIKeysForGroup.anonymous_key.rawValue : anonymous, enumAPIKeysForGroup.disperseDate_key.rawValue: disperseDate, enumAPIKeysForGroup.disperse_key.rawValue : disperse, enumAPIKeysForGroup.members_key.rawValue: members] as [String : Any]
        print("create group dict ...", dict)
        
        self.createGroup(dict: dict)
        
    }
    

    // MARK: - Button Actions

    @objc func createGroupBtnAction() {
        let groupName = CommonFxns.trimString(string: self.groupNameLbl.text ?? emptyStr)
        let groupDescription = CommonFxns.trimString(string: self.groupDescLbl.text ?? emptyStr)
        
        guard !groupName.isEmpty && !groupDescription.isEmpty else{
            CommonFxns.showAlert(self, message: "Enter all the valid information to create the group", title: "Alert")
            return
        }
        
        self.selectedImage == nil ? self.collectParameteresAndCreateGroup(mediaID: emptyStr) : self.uploadGroupImage()
    }
    
    @IBAction func anonymousSwitchAction(_ sender: Any) {
        
        
    }
    
    @IBAction func chooseGroupImgBtnAction(_ sender: Any) {
        
        // Show Image picker
        self.imagePicker.present(from: sender as! UIButton)
    }
    
    @IBAction func disperseGroupBtnAction(_ sender: Any) {

        // open data picker
        
    }
    
    func goToGroupChatSsreen(groupID: String?){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
        let otherVC = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupChat .rawValue) as? GroupChatViewController
        otherVC?.groupID = groupID
        self.navigationController?.pushViewController(otherVC!, animated: true)
    }

}


extension CreateGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.selectedGroupParticipants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let membersCell = self.membersCollectionView.dequeueReusableCell(withReuseIdentifier: GroupMembersListCollectionViewCell.identifier, for: indexPath) as? GroupMembersListCollectionViewCell else{
            return cell
        }
        let dict = self.selectedGroupParticipants[indexPath.row]
        membersCell.usernameLbl.text = dict.username
        
        return membersCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 75, height: self.membersCollectionView.frame.height)
    }
        
}

extension CreateGroupViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        if image != nil{
            self.groupImgView.image = image
            self.selectedImage = image
            
        }
    }
}


