//
//  HomeViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties & Delegates

    @IBOutlet weak var allChatsTableview: UITableView!
    @IBOutlet weak var topMenuView: UIView!
    @IBOutlet weak var noChatsLbl: UILabel!
    
   // var contactsList = [GroupParticipantsUserModel]()
    var viewModel = HomeViewModel()
    var sessionList = [SessionList]() // for handling search
//    var sessionsList = [String: Any]()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.allChatsTableview.register(HomeScreenListTableViewCell.nib(), forCellReuseIdentifier: HomeScreenListTableViewCell.identifier)
        self.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setTopBarButtonswithMenu()
        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chats")
        self.setSearchBarOnNavigationBar()
        navigationItem.searchController?.searchBar.delegate = self
        self.navigationItem.largeTitleDisplayMode = .always
//        self.title = "Chats"

//        self.tabBarItem.title = ""
        self.navigationController?.navigationBar.sizeToFit()
    }
    
    func setTopBarButtonswithMenu(){
        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeBtnAction))
//        let moreOptions = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreBtnAction))

        let barButtonMenu = UIMenu(title: "", children: [
            UIAction(title: NSLocalizedString("Add Friend", comment: ""), image: UIImage(named: "homeMenu-addFriendIcon"), handler: { (handler) in
                self.createNewContact()
            }),
            UIAction(title: NSLocalizedString("Call Logs", comment: ""), image: UIImage(named: "homeMenu-callIcon"), handler: { (handler) in
                
                self.goToCallLogsScreen()
            }),
            UIAction(title: NSLocalizedString("Notifications", comment: ""), image: UIImage(named: "homeMenu-notificationsIcon"), handler: { (handler) in
                self.goToNotificationsScreen()
            }),
            UIAction(title: NSLocalizedString("Settings", comment: ""), image: UIImage(named: "homeMenu-settingsIcon"), handler: { (handler) in
                self.goToSettingsScreen()
            })
        ])
        if #available(iOS 14.0, *) {
            let moreOptions =  UIBarButtonItem(title: "Read All", image: UIImage(named: "moreIcon"), primaryAction: nil, menu:barButtonMenu)
            
            self.navigationItem.setRightBarButtonItems([moreOptions, compose], animated: true)

        } else {
            // Fallback on earlier versions
        }

        if #available(iOS 14.0, *) {
            self.navigationItem.rightBarButtonItem?.menu = barButtonMenu
        } else {
            // Fallback on earlier versions
        }
    }
    
    func goToSettingsScreen(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.settings.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.settings.rawValue) as? SettingsViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    func goToNotificationsScreen(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.notifications.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.notifications.rawValue) as? NotificationsViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    func goToCallLogsScreen(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.calls.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.callLogs.rawValue) as? CallLogsViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    func createNewContact(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.searchUsers.rawValue) as? SearchUsersViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
        
//        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
//        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allContactsList.rawValue) as? AllContactsListViewController
//        otherController?.isCreateGroup = false
//        self.navigationController?.pushViewController(otherController!, animated: true)
    }
        
//    override func viewWillDisappear(_ animated: Bool) {
//       super.viewWillDisappear(animated)
//       navigationController?.navigationBar.prefersLargeTitles = false
//    }
//
//    override func willMove(toParent parent: UIViewController?) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//
//        let compose = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addTapped))
//        let play = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(addTapped))
//
//        self.navigationItem.setRightBarButtonItems([play, compose], animated: true)
//
//        self.navigationItem.largeTitleDisplayMode = .always
//
////        self.navigationItem.rightBarButtonItems.
////        navigationController?.setNavigationBarHidden(false, animated: true)
////        navigationController?.setNavigationBarHidden(false, animated: true)
////
////        self.navigationItem.setHidesBackButton(true, animated: false)
////        self.navigationItem.largeTitleDisplayMode = .always
////        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chats")
////        self.setSearchBarOnNavigationBar()
//
//    }
    
    
    @objc func composeBtnAction(){
        print("composeBtnAction")

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.contacts.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.allContactsList.rawValue) as? AllContactsListViewController
        otherController?.comingFor = showContacts
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
//
//    @objc func moreBtnAction(){
//        print("moreBtnAction")
//        self.topMenuView.isHidden = false
//    }
//

    @IBAction func menuViewTapGestureAction(_ sender: Any) {
        
        self.topMenuView.isHidden = true
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        navigationController?.setNavigationBarHidden(false, animated: false)
//
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        self.navigationItem.largeTitleDisplayMode = .always
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chats")
//        self.setSearchBarOnNavigationBar()
//
//
////        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
////        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
////
//
//
//
////        navigationItem.rightBarButtonItems = [add, play]
//
//    }
//
//
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        self.hideSearchBar()
//        navigationController?.navigationBar.prefersLargeTitles = false
//        self.topMenuView.isHidden = true
//    }

    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: true)
//
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        self.topMenuView.isHidden = true
//
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        self.navigationItem.largeTitleDisplayMode = .always
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chats")
//        self.setSearchBarOnNavigationBar()
////        self.hideSearchBar()
//    }

    
//    func setLargeHeaderOnNavigationBar(largeTitleHeader: String){
//        self.title = largeTitleHeader
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//
//        self.navigationController?.navigationBar.sizeToFit()
//
//    }
//
//
//    func setSmallHeaderAndHideLargeHeader(header: String){
//        self.title = header
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//
//    }
//
//    func showNavigationBar(){
//        self.navigationController?.navigationBar.isHidden = false
//    }
//
//    func setSearchBarOnNavigationBar(){
//
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
//    }
    
    // MARK: - Methods for Initial Setup

    // Method for initial Setups
    func initialSetup(){
        setupViemodelClosures()
        viewModel.fetchSessionList()
        viewModel.fetchContacts()
        viewModel.fetchAllGroups()
        //self.fetchContactsFromLocalDB()
    }
    
    func fetchContactsFromLocalDB(){
       // self.contactsList = ContactsDatabaseQueries.fetchAllContactsFromLocalDB()
        //self.allChatsTableview.reloadData()
    }

    

    
    @IBAction func settingsBtnAction(_ sender: Any) {
        
//        let storyBoard = UIStoryboard.init(name: enumStoryBoard.settings.rawValue, bundle: nil)
//        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.settings.rawValue) as? SettingsViewController
//        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func notificationsBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.notifications.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.notifications.rawValue) as? NotificationsViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func callLogsBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateChat.rawValue) as? PrivateChatViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func addFriendBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateChat.rawValue) as? PrivateChatViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let chatCell = self.allChatsTableview.dequeueReusableCell(withIdentifier: HomeScreenListTableViewCell.identifier , for: indexPath) as? HomeScreenListTableViewCell else {
            
            return cell
        }
        chatCell.configureCell(obj: sessionList[indexPath.row])
        
        return chatCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sessionList.count == 0{
            self.noChatsLbl.isHidden = false
            self.noChatsLbl.text = "Make new friends to start a chat."
        }else{
            self.noChatsLbl.isHidden = true
        }
        return sessionList.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if sessionList[indexPath.row].groupId?.isEmpty ?? false{
            self.goToSelectedPrivateChatScreen(index:indexPath.row)
        }else{
            self.goToSelectedGroupChatScreen(groupID: sessionList[indexPath.row].groupId)
        }
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete".localized) {  (contextualAction, view, boolValue) in
            //Code I want to do here
        }
        let pin = UIContextualAction(style: .normal, title: "Pin".localized) {  (contextualAction, view, boolValue) in
            if self.sessionList[indexPath.row].groupId?.isEmpty ?? false{
                let otherUserID = self.sessionList[indexPath.row].getOtherUserID()
                let pinValue = self.sessionList[indexPath.row].isPin ?? 0
            let requestObj = PinUserRequest(pin: pinValue, userId: otherUserID, groupId: "", receiverType: 0)
                self.viewModel.pinUser(param: requestObj.toDictionary())
            }
            else{
                let groupID = self.sessionList[indexPath.row].groupId ?? ""
                let pinValue = self.sessionList[indexPath.row].isPin ?? 0
            let requestObj = PinUserRequest(pin: pinValue, userId: "", groupId: groupID, receiverType: 0)
                self.viewModel.pinUser(param: requestObj.toDictionary())
                
            }
        }
        pin.backgroundColor = UIColor(named: "PrimaryThemeColor")
        
        let mute = UIContextualAction(style: .normal, title: "Mute".localized) { [self]  (contextualAction, view, boolValue) in
            if self.sessionList[indexPath.row].groupId?.isEmpty ?? false{
                let otherUserID = self.sessionList[indexPath.row].getOtherUserID()
            let muteValue = self.sessionList[indexPath.row].isMute ?? 0
                let requestObj = MuteUserRequest(mute: muteValue, userId: otherUserID ,groupId: "", receiverType: 0)
            viewModel.muteUser(param: requestObj.toDictionary())
            }
            else{
                let groupID = self.sessionList[indexPath.row].groupId ?? ""
                let muteValue = self.sessionList[indexPath.row].isMute ?? 0
                let requestObj = MuteUserRequest(mute: muteValue, userId: "",groupId: groupID, receiverType: 0)
                viewModel.muteUser(param: requestObj.toDictionary())
            }
            
        }
        mute.backgroundColor = UIColor(named: "PrimaryThemeColor")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [delete,pin,mute])

        return swipeActions
    }
    
    
    
    func goToSelectedPrivateChatScreen(index:Int){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateChat.rawValue) as? PrivateChatViewController
         let otherUSerID = self.sessionList[index].getOtherUserID()
        otherController?.otherChatUserId = otherUSerID
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    func setTitle(title:String, subtitle:String) -> UIView {

            let titleLabel = UILabel(frame: CGRect(x: 0, y: -2, width: 0, height: 0))

            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = UIColor.gray
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.text = title
            titleLabel.sizeToFit()

            let subtitleLabel = UILabel(frame: CGRect(x:0, y:18, width:0, height:0))
            subtitleLabel.backgroundColor = .clear
            subtitleLabel.textColor = .black
            subtitleLabel.font = UIFont.systemFont(ofSize: 12)
            subtitleLabel.text = subtitle
            subtitleLabel.sizeToFit()


        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: max(self.navigationController?.navigationBar.frame.width ?? 0, self.navigationController?.navigationBar.frame.height ?? 0), height: 30))
            titleView.addSubview(titleLabel)
            titleView.addSubview(subtitleLabel)
        
//        titleView.backgroundColor = UIColor.red

            let widthDiff = subtitleLabel.frame.size.width - titleLabel.frame.size.width

            if widthDiff < 0 {
                let newX = widthDiff / 2
                subtitleLabel.frame.origin.x = abs(newX)
            } else {
                let newX = widthDiff / 2
                titleLabel.frame.origin.x = newX
            }

            return titleView
    }
    
    func goToSelectedGroupChatScreen(groupID:String?){
        print("Group Chat........")

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupChat.rawValue) as? GroupChatViewController
        otherController?.groupID = groupID
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    // MARK: - Methods
    
//    func initialUISetup(){
//        // Hide default navigation Bar and set up custom bar
//
//        self.title = "Chats"
//
//        navigationController?.navigationBar.prefersLargeTitles = true
//
//        let searchController = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = searchController
//
//
//    }
    
}




//MARK: - API Calls
extension HomeViewController{
    
    private func setupViemodelClosures(){
        
        //For showing errors
        viewModel.showAlertClosure = {
            error in
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
  
        }
        
        viewModel.didFinishSessionFeth = {
            self.sessionList = self.viewModel.sessionData?.sessionList ?? []
            self.allChatsTableview.reloadData()
        }
        
        viewModel.didFinishPin = {
            msg in
            
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.SUCCESS_TITLE)
            self.allChatsTableview.reloadData()
        }
        
        viewModel.didFinishMute = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.SUCCESS_TITLE)
            self.allChatsTableview.reloadData()
            
        }
        
        viewModel.didFinishDelete = {
            msg in
            CommonFxns.showAlert(self, message: msg, title: AlertMessages.SUCCESS_TITLE)
        }
        
        
    }
    
    
}

//MARK: - Searchbar Delegates
extension HomeViewController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchSessionList(text: searchText)
        
    }
    
    func searchSessionList(text:String){
        if text == ""{
            self.sessionList = self.viewModel.sessionData?.sessionList ?? []
            self.allChatsTableview.reloadData()
        }
        else{
            self.sessionList = self.viewModel.sessionData?.sessionList?.filter{$0.username?.lowercased().contains(text.lowercased()) ?? false} ?? []
            self.allChatsTableview.reloadData()
            
        }
    }
}

