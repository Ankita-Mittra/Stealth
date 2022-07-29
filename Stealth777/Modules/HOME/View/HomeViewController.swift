//
//  HomeViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit
import CoreMedia
import Network

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties & Delegates

    @IBOutlet weak var allChatsTableview: UITableView!
    @IBOutlet weak var topMenuView: UIView!
    @IBOutlet weak var noChatsLbl: UILabel!

    // MARK: - Injection
    let viewModel = HomeViewModel()
    
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
        
        
        /*  Fetch ContactList, fetch GroupList, fetch sessionList
         --Update contactList locally and Update groupList Locally and keep sessions list in arrays only.
         --on selection of group head, fetch groupId from array and go to next screen(Group chat screen)
         --fetch groupinfo from local and display on screen and display all the messages coming from api response.
         --on selection of chat head, fetch otherUserId from array and go to next screen(private chat screen)
         --fetch otherUserInfo from local and display on screen and display all the messages coming from api response and
         --fetch own key pair to ecrypt and decrypt message  */
        self.fetchContactsList()
        self.fetchSession()
        self.fetchGroups()
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
        chatCell.configureCell(obj: viewModel.sessionData?.sessionList?[indexPath.row])
        
        return chatCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.sessionData?.sessionList?.count == 0{
            self.noChatsLbl.isHidden = false
            self.noChatsLbl.text = "Make new friends to start a chat."
        }else{
            self.noChatsLbl.isHidden = true
        }
        return viewModel.sessionData?.sessionList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 78
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if viewModel.sessionData?.sessionList?[indexPath.row].groupId != emptyStr{
            self.goToSelectedGroupChatScreen()
        }else{
            self.goToSelectedPrivateChatScreen(index:indexPath.row)
        }
    }
    
    func goToSelectedPrivateChatScreen(index:Int){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.privateChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateChat.rawValue) as? PrivateChatViewController
        guard let dict = viewModel.sessionData?.sessionList?[index].getChatUserDict() else {return}
        let user = ChatUser(dict: dict)
        otherController?.chatUser = user
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
    
    func goToSelectedGroupChatScreen(){
        print("Group Chat........")

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupChat.rawValue) as? GroupChatViewController
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

// MARK: - UI Setup
extension HomeViewController{

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


// MARK: - API Calls
extension HomeViewController{
    private func fetchContactsList() {
        viewModel.fetchContacts()

        viewModel.updateLoadingStatus = {
            print("updateLoadingStatus")

            self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }

        viewModel.showAlertClosure = {
            error in
            print(error)
            print("showAlertClosure")
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
  
        }
        
        viewModel.didFinishFetch = {
            print("Saving data to Local DB")
          
            ContactsDatabaseQueries.addAndUpdateContactsInLocalDB(contacts : self.viewModel.contactsList ?? [])
        }
        
        
        
    }
    // MARK: - Handling session list

    private func fetchSession(){
        viewModel.fetchSessionList()

        viewModel.showSessionListError = {
            error in
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
        }
        
        viewModel.didFinishSessionFetch = {
            self.allChatsTableview.reloadData()
        }
    }
    
    private func fetchGroups(){
        viewModel.fetchAllGroups()

        viewModel.showGroupListError = {
            error in
            CommonFxns.showAlert(self, message: error, title: AlertMessages.ERROR_TITLE)
        }
        
        viewModel.didFinishGroupFetch = {
            
            // save group locally
        }
    }
    
    
    
}
