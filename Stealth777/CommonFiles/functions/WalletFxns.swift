//
//  WalletFxns.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 20/05/2022.
//

import UIKit
import BinanceSmartChainSDK
import web3swift

class WalletFxns: NSObject {

    // Check Wallet balance
    class func importToken(walletAddress: String, contractAddress: String)-> [String: Any]{

        var importedTokenInfoDict = [String: Any]()
        do{
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")
            
            if let tokenInfoDict = try binance.importBEP20TokenAndGetBalance(tokenContractAddress: contractAddress, walletAddress: walletAddress){
                print("tokenInfoDict....", tokenInfoDict)
                importedTokenInfoDict = tokenInfoDict
            }

        }catch let error {
            print("error...", error)
        }
        return importedTokenInfoDict
    }
    
}
