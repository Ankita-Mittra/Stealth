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

        let walletAddress = self.walletAddress // "0x4b8dbF6Fa6777F4bdE11a3d0A652843FE82fbF32"
        do{
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")

            let balance = try binance.getBnbBalance(walletAddress: walletAddress)
            
            let armoneyContractAddress = "0xe142480898845f5270ee4A47Ad8D479bd37e6A3B"
            let USDTContractAddress = "0x55d398326f99059ff775485246999027b3197955"
            let tokenBalance = try binance.getBEP20TokenBalance(tokenContractAddress: armoneyContractAddress, walletAddress: walletAddress)
            

            print("BNB balance...", balance)
            print("BNB tokenBalance...", tokenBalance)

            binance.testing()
            let tokenAmount = 0.001
            let receiverAddress = ""
            
            let gasPrice = 0.0007
            let gasLimit = 0.0007

        }catch let error {
            print("error...", error)
        }
    }
    
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
