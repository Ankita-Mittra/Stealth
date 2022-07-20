//
//  SendFundsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit
import BinanceSmartChainSDK
import web3swift

//import SwiftyJSON
//import Alamofire
//import BigInt

class SendFundsViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var accountAddressLbl: UILabel!
    var walletAddress = String()
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetup()
        
        self.importBinanceWallet2()
//        self.importBinanceWallet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never

//        self.navigationItem.titleView = setTitle(title: "Username", subtitle: "status")
        
//        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.setSmallHeaderAndHideLargeHeader(header: "Send")
    }
    
    // MARK: - Methods

    func initialSetup(){
        self.accountAddressLbl.text = self.walletAddress
    }
    
    func checkWalletBalance(walletAddress: String){
        print("check balance........", walletAddress)
//        let walletAddress = self.walletAddress // "0x4b8dbF6Fa6777F4bdE11a3d0A652843FE82fbF32"
        do{
            
            let eth = EthWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")
            let balance = try eth.getEthBalance(walletAddress: walletAddress)
            print("vbalance....", balance)

            let armoneyContractAddress = "0xe142480898845f5270ee4A47Ad8D479bd37e6A3B"
            let USDTContractAddress = "0x55d398326f99059ff775485246999027b3197955"
            let tokenBalance = try eth.getBEP20TokenBalanceEth(tokenContractAddress: armoneyContractAddress, walletAddress: walletAddress)
            
            
            print("ETh balance...", balance)
            print("Eth tokenBalance...", tokenBalance)
            
            let tokenAmount = 0.0001
            let receiverAddress = ""
            
            let gasPrice = 0.0001
            let gasLimit = 0.0001

        }catch let error {
            print("error...", error)
        }
    }
    
    func importBinanceWallet(){
        do {
            
            let eth = EthWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")

            if let walletPhrase = try BIP39.generateMnemonics(bitsOfEntropy: 128, language: .english){

                print("walletPhrase.....", walletPhrase)

                let wallet = try eth.createEthWallet(walletPhrase: walletPhrase)

                print("wallet111111111....", wallet?.walletAddress)
                
                self.checkWalletBalance(walletAddress: "0xa3e26d47ca97a475a879bfd99c8fef4bf1ca74bc") //(wallet?.walletAddress)!)
                eth.sendEthTesting(walletAddress: "0xa3e26d47ca97a475a879bfd99c8fef4bf1ca74bc")
//                eth.sendBNBTesting(walletAddress: "0xa3e26d47ca97a475a879bfd99c8fef4bf1ca74bc")//(wallet?.walletAddress)!)
            }
            // 0xf7De5c1d48123E6B446b1ce189A31F04a01cb279
            
            // SENDER.. 0x61206e93876363296a0cd53c3cd88a3ed9c32b93  ???
            
            // walletPhrase..... antique urban blanket fantasy because south barrel torch you arrive captain soap

//            let walletAdrress = "0xf7De5c1d48123E6B446b1ce189A31F04a01cb279"
            
//             eth.sendEthTesting(walletAddress: walletAddress)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func importBinanceWallet2(){
        do {
            
            // 0x9873dFC5442F589d01cFe19aF035D96C898eBa0b
            
            
            let binance = BnbWalletManager.init(infuraUrl:  "https://bsc-dataseed1.binance.org:443")//)
            
            
            if let walletPhrase = try BIP39.generateMnemonics(bitsOfEntropy: 128, language: .english){
                
                let wallet = try binance.createWallet(walletPhrase: walletPhrase)

                print("wallet....",wallet?.walletAddress)
                binance.sendBNBTesting(walletAddress: wallet?.walletAddress ?? "") //(wallet?.walletAddress)!)

            }
            let wallet = try binance.createWallet(walletPassword: "")
            print("wallet....",wallet?.walletAddress)
            binance.sendBNBTesting(walletAddress: wallet?.walletAddress ?? "") //(wallet?.walletAddress)!)
//            binance.sendBNBTesting(walletAddress: "0xa3e26d47ca97a475a879bfd99c8fef4bf1ca74bc")//(wallet?.walletAddress)!)
//
//            self.checkWalletBalance(walletAddress: "0xa3e26d47ca97a475a879bfd99c8fef4bf1ca74bc")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
//    func checkWalletBalance(walletAddress: String){
//
//        print("check balance........")
//        let walletAddress = self.walletAddress // "0x4b8dbF6Fa6777F4bdE11a3d0A652843FE82fbF32"
//        do{
//            let binance = BnbWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")//"https://bsc-dataseed1.binance.org:443")
//
//            let balance = try binance.getBnbBalance(walletAddress: walletAddress)
//
//            let armoneyContractAddress = "0xe142480898845f5270ee4A47Ad8D479bd37e6A3B"
//            let USDTContractAddress = "0x55d398326f99059ff775485246999027b3197955"
//            let tokenBalance = try binance.getBEP20TokenBalance(tokenContractAddress: armoneyContractAddress, walletAddress: walletAddress)
//
//
//            print("BNB balance...", balance)
//            print("BNB tokenBalance...", tokenBalance)
//
////            binance.sendBNBTesting()
//            let tokenAmount = 0.0001
//            let receiverAddress = ""
//
//            let gasPrice = 0.0001
//            let gasLimit = 0.0001
//
//        }catch let error {
//            print("error...", error)
//        }
//    }
//
    
    func importBinanceWallet22(){
        do {
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")

            if let walletPhrase = try BIP39.generateMnemonics(bitsOfEntropy: 128, language: .english){

                print("walletPhrase.....", walletPhrase)

//                let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")

                let wallet = try binance.createWallet(walletPhrase: walletPhrase)
                print("wallet1....", wallet?.walletAddress)

                self.checkWalletBalance(walletAddress: "0x61206e93876363296a0cd53c3cd88a3ed9c32b93")//(wallet?.walletAddress)!)
            }
            // 0xf7De5c1d48123E6B446b1ce189A31F04a01cb279

            // SENDER.. 0x61206e93876363296a0cd53c3cd88a3ed9c32b93  ???

            // walletPhrase..... antique urban blanket fantasy because south barrel torch you arrive captain soap

            let walletAdrress = "0xf7De5c1d48123E6B446b1ce189A31F04a01cb279"
//            binance.sendBNBTesting(walletAddress: walletAdrress)

            let keyStore = try binance.exportKeystore(walletAddress: walletAdrress)
            print("keyStore....", keyStore)
        } catch {
            print(error.localizedDescription)
        }
    }
    

//    func importBinanceWallet2(){
//        do {
//            let binance = BnbWalletManager.init(infuraUrl:  "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")//"https://bsc-dataseed1.binance.org:443")
//
//            let wallet = try binance.createWallet(walletPassword: "")
//            print("wallet2....", wallet?.walletAddress)
//
//            binance.sendBNBTesting(walletAddress: (wallet?.walletAddress)!)
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
//
    // Method to go to next screen
    func goToNextScreen(){
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.transferAmount.rawValue) as? TransferAmountViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        self.checkWalletBalance(walletAddress: self.walletAddress)
    }
    
    

}
