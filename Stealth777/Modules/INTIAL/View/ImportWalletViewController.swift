//
//  ImportWalletViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit
import SwiftUI
import BinanceSmartChainSDK
import web3swift

import SwiftyJSON
import Alamofire
import BigInt
//import BinanceChain

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
        
        self.enterRecoveryPhraseTxtField.text = "gentle essence eye scene hurt manage dinner net foam spirit cube circle"//"chair obscure choose right piano dinner weather scatter pony drum wash ready"
    }
    
    func importWallet(walletPhrase: String){

        // chair obscure choose right piano dinner weather scatter pony drum wash ready
        do {
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")
            
            let wallet = try binance.createWallet(walletPhrase: walletPhrase)
            let walletWithPassword = try binance.createWallet(walletPassword: "stealth777")

            //          bnb2.web3Manager.transactionOptions.from
            self.walletAddress = wallet?.walletAddress ?? emptyStr

            let walletkeystore = wallet?.keystore
            
            self.importedWalletAdd = walletAddress
            print("importedWalletAdd....", importedWalletAdd , "   ", walletAddress)

            self.checkWalletBalance(walletAddress: walletAddress)
            
            let tokenAmount = 0.001
            let receiverAddress = ""
            
            let gasPrice = 0.0007
            let gasLimit = 0.0007
            print("gasPrice", gasPrice)
            binance.testing()

//            bnb2.sendBnb(walletAddress: "", password: "", receiverAddress: "", etherAmount: "", gasPrice: 0, gasLimit: 0)
//            bnb2.sendBnb(walletAddress: "", password: "", receiverAddress: "", etherAmount: "", gasPrice: 0, gasLimit: 0)
            
//            walletManager.sendBEP20Token(walletAddress: "", password: "", receiverAddress: "", tokenAmount: tokenAmount, tokenContractAddress: "", gasPrice: gasPrice, gasLimit: gasLimit)
            print("gasPrice...", gasPrice)
            
//            sendBnb(walletAddress: <#T##String#>, password: <#T##String#>, receiverAddress: <#T##String#>, etherAmount: <#T##String#>, gasPrice: <#T##BigUInt#>, gasLimit: <#T##BigUInt#>)

//            sendBnb(walletAddress: <#T##String#>, password: <#T##String#>, receiverAddress: <#T##String#>, etherAmount: <#T##String#>, gasPrice: <#T##BigUInt#>, gasLimit: <#T##BigUInt#>)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    var importedWalletAdd = String()
    
    func checkWalletBalance(walletAddress: String){

        let walletAddress2 = importedWalletAdd //"0x4b8dbF6Fa6777F4bdE11a3d0A652843FE82fbF32"
        do{
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")

            let balance = try binance.getBnbBalance(walletAddress: walletAddress2)
            
            let armoneyContractAddress = "0xe142480898845f5270ee4A47Ad8D479bd37e6A3B"
            let USDTContractAddress = "0x55d398326f99059ff775485246999027b3197955"
            let tokenBalance = try binance.getBEP20TokenBalance(tokenContractAddress: armoneyContractAddress, walletAddress: walletAddress2)
            

            print("BNB balance...", balance)
            print("BNB tokenBalance...", tokenBalance)

            let tokenAmount = 0.001
            let receiverAddress = ""
            
            let gasPrice = 0.0007
            let gasLimit = 0.0007

//            binance.testing()
            
//            binance.sendBnb(walletAddress: "", password: "", receiverAddress: "", etherAmount: "", gasPrice: "", gasLimit: "")

//            try binance.sendBnb(walletAddress: walletAddress2, password: "", receiverAddress: receiverAddress, etherAmount: tokenAmount, gasPrice: gasPrice, gasLimit: gasLimit)
            
//            try binance.sendBEP20Token(walletAddress: walletAddress2, password: "", receiverAddress: receiverAddress, tokenAmount: tokenAmount, tokenContractAddress: armoneyContractAddress, gasPrice: gasPrice, gasLimit: gasLimit)
            
        
//            // Get token list
//            let binanceChain = BinanceChain()
//
//            binanceChain.tokens(limit: .fiveHundred, offset: 0) { (response) in
//                print(response.tokens)
//            }
//
//            // Obtain trading fees information
//            binance.fees() { (response) in
//                print(response.fees)
//            }
        }catch let error {
            print("error...", error)
        }

    }

    
    // MARK: - Button Actions
    
    @IBAction func submitBtnAction(_ sender: Any) {

        if let recoveryPhrase = self.enterRecoveryPhraseTxtField.text{
            self.importWallet(walletPhrase: recoveryPhrase)
        }
        
//        self.goToHomeScreen()
        
        
    }

    func goToHomeScreen(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar.rawValue) as? PublicModeTabBarViewController
                    self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
        
}


extension ImportWalletViewController: UITextViewDelegate{
    
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        textView.text = emptyStr
        return true
    }
}
