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
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initial Setup
        self.initialUISetup()
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)

        self.setNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        self.setNavigationBar()
    }

    func setNavigationBar(){

        self.title = "Wallet"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)

        let play = UIBarButtonItem(image: UIImage(named: "moreIcon"), style: .plain, target: self, action: #selector(moreButtonAction))
        self.navigationItem.setRightBarButtonItems([play], animated: true)

//        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Wallet")
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
    }

    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.sizeToFit()
    }
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

    @objc func  moreButtonAction(){
        print("Open wallet list")
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.walletList.rawValue) as? WalletListViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    // MARK: - Methods

    func initialUISetup(){
        self.tokensListTableView.register(TokenListTableViewCell.nib(), forCellReuseIdentifier: TokenListTableViewCell.identifier)
    }
    
    // MARK: - Button Actions
    
    @IBAction func sendAmountBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.sendFunds.rawValue) as? SendFundsViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func receiveAmountBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.receiveAmount.rawValue) as? ReceiveAmountViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    @IBAction func QRScanBtnAction(_ sender: Any) {

    }

    @IBAction func importTokenBtnAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.importToken.rawValue) as? ImportTokenViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    

}





extension WalletDetailsViewController: UITableViewDelegate, UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    guard  let tokenCell = self.tokensListTableView.dequeueReusableCell(withIdentifier: TokenListTableViewCell.identifier , for: indexPath) as? TokenListTableViewCell else {
        return cell
    }
    
    return tokenCell
}

}


