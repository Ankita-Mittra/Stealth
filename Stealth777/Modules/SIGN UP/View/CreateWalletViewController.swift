//
//  CreateWalletViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit
import SwiftUI
import BinanceSmartChainSDK
import web3swift
import MBProgressHUD

class CreateWalletViewController: BaseViewController {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    @IBOutlet weak var copyBtn: UIButton!
    
    var walletAddress = String()
    var signUpDict = [String:Any]()
    var walletPhraseArr = [Any]()
    var walletPhraseString = ""
    
    // MARK: - Injection
    
    let viewModel = CreateWalletViewModel(apiService: SignUpAPIService())
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial UI setup
        self.importBinanceWallet()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillLayoutSubviews() {
        self.phraseCollectionView.reloadData()
    }

    // MARK: - Methods
    
    func importBinanceWallet(){
        do {
            if let walletPhrase = try BIP39.generateMnemonics(bitsOfEntropy: 128, language: .english){
                self.walletPhraseString = walletPhrase
                
                walletPhraseArr = walletPhrase.words
                print("phrase.....", walletPhraseArr.count)
                
                print("phrase.....", walletPhraseArr)

                for i in walletPhraseArr{
                    print("phrase ...", i)
                }
                let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")
                
                let wallet = try binance.createWallet(walletPhrase: walletPhrase)
                
//                    if let phrase = walletPhrase.words as? [String]{
//                        self.mneomonicPhraseArr = phrase
//                    }
                self.phraseCollectionView.reloadData()
                
                self.walletAddress = wallet?.walletAddress ?? emptyStr
                self.signUpDict["walletKey"] = walletAddress
                self.viewModel.walletAddress = walletAddress
                print("wallet....", walletAddress)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
 
    // MARK: - Networking
    
    private func registerUser() {
        
        viewModel.registerUser(dict: self.signUpDict)
    
        viewModel.updateLoadingStatus = {
            
            print("updateLoadingStatus")

            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            print("showAlertClosure")

            if let error = self.viewModel.error {
                print( "error...", error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            print("didFinishFetch.....")
            
            // stop indicator loader
            self.goToHomeScreen()
        }
    }
    
    // MARK: - UI Setup
    
    private func activityIndicatorStart() {
        // Code for show activity indicator view
        // ...
        print("start")
    }
    
    private func activityIndicatorStop() {
        // Code for stop activity indicator view
        // ...
        print("stop")
    }
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        signUpDict[enumAPIKeysForUser.walletId_key.rawValue] = self.walletAddress
        
        self.registerUser()
        
    }
    
    @IBAction func copyBtnAction(_ sender: Any) {
        print(walletPhraseString)
        
        UIPasteboard.general.string = walletPhraseString
        
    }
    
    // MARK: - Methods
    
    // Go to Home screen
    func goToHomeScreen(){
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let nextVcObj = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar .rawValue) as? PublicModeTabBarViewController
        self.navigationController?.pushViewController(nextVcObj!, animated: true)
    }

}



