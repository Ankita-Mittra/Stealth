//
//  ImportWalletViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit
import UIKit
import SwiftUI
import BinanceSmartChainSDK
import web3swift

class ImportWalletViewController: BaseViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var enterRecoveryPhraseTxtField: UITextView!
    var walletAddress = String()

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Import Wallet"
//        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
    
    func initialSetup(){

    }
    
    func importWallet(walletPhrase: String){

        do {
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")
            
            let wallet = try binance.createWallet(walletPhrase: walletPhrase)

            self.walletAddress = wallet?.walletAddress ?? emptyStr
            
            print("wallet....", walletAddress)
            
            self.checkWalletBalance(walletAddress: walletAddress)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    func checkWalletBalance(walletAddress: String){

        let walletAddress2 = "0x4b8dbF6Fa6777F4bdE11a3d0A652843FE82fbF32"
        do{
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")

            let balance = try binance.getBnbBalance(walletAddress: walletAddress2)
            
            let armoneyContractAddress = "0xe142480898845f5270ee4A47Ad8D479bd37e6A3B"
            let USDTContractAddress = "0x55d398326f99059ff775485246999027b3197955"
            let tokenBalance = try binance.getBEP20TokenBalance(tokenContractAddress: armoneyContractAddress, walletAddress: walletAddress2)
            
            
            
            print("BNB balance...", balance)
            
            print("BNB tokenBalance...", tokenBalance)
        }catch let error {
            print("error...", error)
        }

    }
    
    
    // MARK: - Button Actions
    
    @IBAction func submitBtnAction(_ sender: Any) {

        if let recoveryPhrase = self.enterRecoveryPhraseTxtField.text{
            self.importWallet(walletPhrase: recoveryPhrase)
        }
        
        
    }

    func goToHomeScreen(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar.rawValue) as? PublicModeTabBarViewController
                    self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
        
}
