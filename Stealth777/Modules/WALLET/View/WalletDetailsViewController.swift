//
//  WalletDetailsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 07/03/2022.
//

import UIKit

class WalletDetailsViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var tokensListTableView: UITableView!
    @IBOutlet weak var walletAddressLbl: UILabel!
    
    @IBOutlet weak var selectedNetworkLbl: UILabelCustomClass!
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

    func setNavigationBar(){

        self.title = "Wallet"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)

        let play = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreButtonAction))
        self.navigationItem.setRightBarButtonItems([play], animated: true)

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
    
    var currentSelectedNetwork = "Binance"
    // Binance//Ethereum
    
    // save in local
    @IBAction func switchBlockchainNetworkBtnAction(_ sender: Any) {
        if currentSelectedNetwork == "Binance"{

            print("")
        }else{
        
            
        }
        
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
