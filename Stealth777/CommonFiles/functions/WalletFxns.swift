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
    
    class func sendBNb(){}
    class func sendEth(){}

    class func createBnbWallet(){
        
    }
    class func createEthWallet(){
        
    }
    
    class func checkBnbWalletBalance(walletAddress: String)->String{
        do{
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")
            let balance = try binance.getBnbBalance(walletAddress: walletAddress)

            return balance ?? ""
        }catch let error {
            print("error...", error)
            return ""
        }
    }
    
    class func checkBEP20TokenBalance(walletAddress: String, tokenContractAddress: String){
        do{
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")
            let balance = try binance.getBEP20TokenBalance(tokenContractAddress: tokenContractAddress, walletAddress: walletAddress)

        }catch let error {
            print("error...", error)
        }
    }
    
    class func checkEthWalletBalance(walletAddress: String){
        do{
            
            let eth = EthWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")
            let balance = try eth.getEthBalance(walletAddress: walletAddress)
            
        }catch let error {
            print("error...", error)
        }
    }
    
    class func checkEthBEP20TokenBalance(walletAddress: String, tokenContractAddress: String){
        do{
            let eth = EthWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")
            let balance = try eth.getBEP20TokenBalanceEth(tokenContractAddress: tokenContractAddress, walletAddress: walletAddress)

        }catch let error {
            print("error...", error)
        }
    }
    
    func checkEthWalletBalance(walletAddress: String){
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
    class func checkEthWalletBalance(){
        
    }
    
}
