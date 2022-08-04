//
//  WalletDetailsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 07/03/2022.
//

import UIKit

import UIKit

class WalletDetailsViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var tokensListTableView: UITableView!
    @IBOutlet weak var walletAddressLbl: UILabel!
    @IBOutlet weak var walletBalanceLbl: UILabel!

    @IBOutlet weak var selectedBlockchainNetworkLbl: UILabel!

    var selectedBlockchainNetwork = "Binance"
    var tokenListArr = [ImportedTokenList]()
        
    lazy var refreshControl: UIRefreshControl = {
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action:
                         #selector(handleRefresh(_:)),
                                     for: UIControl.Event.valueChanged)
            refreshControl.tintColor = UIColor.red
            
            return refreshControl
    }()
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial Setup
        self.initialUISetup()
        
        let abcDate = self.getReadableDateInDefaultPattern(timeStamp: 1659533870000)
        print("abcDate...", abcDate ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Initial Setup
        navigationController?.setNavigationBarHidden(false, animated: false)
        self.setNavigationBar()
        
        self.fetchTokensAndShowOnScreen()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.setNavigationBar()
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Methods

    
    func getReadableDateInDefaultPattern(timeStamp: TimeInterval) -> String? {
        
        let date = Date(timeIntervalSince1970: timeStamp/1000)
        let dateFormatter = DateFormatter()
        
//        if LocalizationSystem.sharedInstance.getLanguage() == arabicLanguage {
//            let loc = Locale(identifier: arabicLanguage)
//            dateFormatter.locale = loc
//        }else{
//            let loc = Locale(identifier: englishLanguage)
//            dateFormatter.locale = loc
//        }
        if Calendar.current.isDateInToday(date) {
            
            print("today")
            dateFormatter.dateFormat = "h:mm a"

            return dateFormatter.string(from: date) //LocalizationSystem.sharedInstance.localizedStringForKey(key:"tomorrow", comment: emptyStr)
        } else if Calendar.current.isDateInYesterday(date) {
//            dateFormatter.dateFormat = "h:mm a"
            print("yesterday")

            return "\(LocalizationSystem.sharedInstance.localizedStringForKey(key:"yesterday", comment: emptyStr))" //  \(dateFormatter.string(from: date))
        } else if dateFallsInCurrentWeek(date: date) {
            
            print("dateFallsInCurrentWeek")

            if Calendar.current.isDateInToday(date) {
                
                
                dateFormatter.dateFormat = "h:mm a"
                return dateFormatter.string(from: date)
            } else {
                dateFormatter.dateFormat = "EEEE" //(Thursday)
                return dateFormatter.string(from: date)
            }
        } else {
            
            print("else")

            dateFormatter.dateFormat = "dd/MM/YYYY"//"dd/MM/YYYY, h:mm a"//"MMM d, h:mm a" (nov,12 12:00 AM)
            return dateFormatter.string(from: date)
        }
    }
    
    
    // Method to show days
    func dateFallsInCurrentWeek(date: Date) -> Bool {
//        let currentWeek = Calendar.current.component(Calendar.Component.day, from: Date())
//        let datesWeek = Calendar.current.component(Calendar.Component.day, from: date)
//        print(datesWeek)
//
        let days = Date().days(sinceDate: date ) ?? 0
       
        return days < 7 && days > 1
    }
    
    func setNavigationBar(){

        self.title = "Wallet"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)

//        let play = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreButtonAction))
//        self.navigationItem.setRightBarButtonItems([play], animated: true)

        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
    }
    
    func initialUISetup(){
        self.tokensListTableView.register(TokenListTableViewCell.nib(), forCellReuseIdentifier: TokenListTableViewCell.identifier)
        
        // Show Wallet details on screen
        guard  let userInfoDict = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String: Any] else {
            return
        }
        if let userWalletAddress = userInfoDict[USER_DEFAULT_walletAddress_Key] as? String{
            print("userWalletAddress....", userWalletAddress)
            
            self.walletAddressLbl.text = userWalletAddress
        }
        self.tokensListTableView.addSubview(self.refreshControl)
    }

    func fetchTokensAndShowOnScreen(){
        // fetch tokens list stored locally with balance
        // Show Wallet details on screen
        
        let list =  UserDefaultsToStoreUserInfo.fetchImportedTokenForLoggedInUser()
        self.tokenListArr = list
        
        print("tokenListArr....", tokenListArr)
        self.tokensListTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Button Actions
    
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
           
        print("handle refresh")
        self.fetchTokensAndShowOnScreen()
    }
    
    @objc func  moreButtonAction(){
        print("Open wallet list")
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.walletList.rawValue) as? WalletListViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func sendAmountBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.sendFunds.rawValue) as? SendFundsViewController
        otherController?.walletAddress = self.walletAddressLbl.text ?? emptyStr
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func receiveAmountBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.receiveAmount.rawValue) as? ReceiveAmountViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func importTokenBtnAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.importToken.rawValue) as? ImportTokenViewController
        
        otherController?.walletAddress = self.walletAddressLbl.text ?? emptyStr
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func QRScanBtnAction(_ sender: Any) {
        
    }
        
    @IBAction func changeBlockchainNetworkBtnAction(_ sender: Any) {

        if selectedBlockchainNetwork == "Binance"{
            selectedBlockchainNetwork = "Ethereum"
        }else{
            selectedBlockchainNetwork = "Binance"
        }
        self.selectedBlockchainNetworkLbl.text = selectedBlockchainNetwork
    }
}

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        self.tabBarController?.tabBar.isHidden = false
//        self.navigationController?.setToolbarHidden(true, animated: true)
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//
//        let play = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreButtonAction))
//        self.navigationItem.setRightBarButtonItems([play], animated: true)
//
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Wallet")
//        self.navigationItem.largeTitleDisplayMode = .always
//        self.navigationController?.navigationBar.sizeToFit()
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        self.title = "Wallet"
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Wallet")
//
//
//        let play = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreButtonAction))
//
//        self.navigationItem.setRightBarButtonItems([play], animated: true)
////        self.hideSearchBar()
//
////        navigationController?.setNavigationBarHidden(false, animated: true)
////        navigationController?.setNavigationBarHidden(false, animated: true)
////
////        self.navigationItem.setHidesBackButton(true, animated: false)
////        self.navigationItem.largeTitleDisplayMode = .always
////        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chats")
////        self.setSearchBarOnNavigationBar()
//
//    }
//
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        self.title = "Wallet"
//
//        navigationController?.setNavigationBarHidden(false, animated: false)
//
//        self.navigationItem.setHidesBackButton(true, animated: false)
//        self.navigationItem.largeTitleDisplayMode = .always
//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Wallet")
////
////        let startChat = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(startChatBtnAction)) //UIBarButtonItem(image: UIImage(named: "bIcon"), style: .plain, target: self, action: #selector(startChatBtnAction))
////        let more = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreBtnAction))
////
////        navigationItem.rightBarButtonItems = [more, startChat]
//
//    }
