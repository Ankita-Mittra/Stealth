//
//  WalletListViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class WalletListViewController: BaseViewController {
    
    // MARK: - Properties & Delegates

    @IBOutlet weak var walletListTableView: UITableView!

    let walletListTitleArr = ["Account 1", "Account 2"]
//    let settingsListTitleImgArr = ["privateAvatar","settings-account","settings-generalSettings", "settings-about", "settings-privacyPolicy", "settings-about", "settings-logout"]
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialUISetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        navigationController?.setNavigationBarHidden(false, animated: false)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {

        self.navigationItem.largeTitleDisplayMode = .never
        self.setSmallHeaderAndHideLargeHeader(header: "Wallets")
    }
    
    // MARK: - Methods

    func initialUISetup(){
        self.walletListTableView.register(TokenListTableViewCell.nib(), forCellReuseIdentifier: TokenListTableViewCell.identifier)
    }
    
    
    // MARK: - Button Actions
    
    @IBAction func importWalletBtnAction(_ sender: Any) {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.importNewWallet.rawValue) as? ImportNewWalletViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }

}


extension WalletListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.walletListTitleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let walletCell = self.walletListTableView.dequeueReusableCell(withIdentifier: TokenListTableViewCell.identifier , for: indexPath) as? TokenListTableViewCell else {
            return cell
        }
        
        walletCell.titleLbl.text = "Account \(indexPath.row + 1)"
        walletCell.titleImgView.image = UIImage(named: "wallet")
        if indexPath.row == 0{
            walletCell.cellSelectedBtn.isHidden = false
        }
        
        return walletCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
            let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.transactionsHistory.rawValue) as? TransactionsHistoryViewController
            self.navigationController?.pushViewController(otherController!, animated: true)
        default:
            break
        }

    }

}


