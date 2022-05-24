//
//  UserDefaults.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/04/2022.
//

import UIKit

class UserDefaultsToStoreUserInfo: NSObject {

    // Method to save userInfo(private and public key, userId, token) locally
    class func saveUserDataInUserDefaults(token: String, userId: String, publicKey: String, privateKey: String, walletAddress: String){
        
        var userInfo: [String: Any] = [:]
        
        userInfo = [USER_DEFAULT_token_Key: token, USER_DEFAULT_userID_Key: userId, USER_DEFAULT_privateKey_Key: privateKey, USER_DEFAULT_publicKey_Key: publicKey, USER_DEFAULT_walletAddress_Key: walletAddress ]
        
        print("userInfo....", userInfo)

        userDefault.set(userInfo, forKey: USER_DEFAULT_userInfo_Key)
    }
    
    
    class func saveImportedTokenForLoggedInUser1(tokenContractAddress: String, userId: String, tokenName: String, tokenSymbol: String, tokenBalance: String, tokenPrecision: String){
        
        var userTokenInfoList = [[String: Any]]()
        
        if let tokenInfoObject = ImportedTokenList(name: tokenName, symbol: tokenSymbol, decimals: tokenPrecision, balance: tokenBalance, contractAddress: tokenContractAddress).toAnyObject() as? [String : Any]{
            
            print("tokenInfoObject....", tokenInfoObject)

            userTokenInfoList.append(tokenInfoObject)
            userDefault.set(userTokenInfoList, forKey: USER_DEFAULT_userTokensList_Key)
        }
        
//        let tokenInfoObject = [USER_DEFAULT_tokenContractAddress_Key: tokenContractAddress, USER_DEFAULT_userID_Key: userId, USER_DEFAULT_tokenName_Key: tokenName, USER_DEFAULT_tokenBalance_Key: tokenBalance, USER_DEFAULT_tokenSymbol_Key: tokenSymbol, USER_DEFAULT_tokenPrecision_Key: tokenPrecision]
        
    }
    
    
    
    class func saveImportedTokenForLoggedInUser(tokenContractAddress: String, userId: String, tokenName: String, tokenSymbol: String, tokenBalance: String, tokenPrecision: String){
        
        var userTokenInfoList = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) as? [[String:Any]]
        
        
        if let tokenInfoObject = ImportedTokenList(name: tokenName, symbol: tokenSymbol, decimals: tokenPrecision, balance: tokenBalance, contractAddress: tokenContractAddress).toAnyObject() as? [String : Any]{
            
            print("tokenInfoObject....", tokenInfoObject)

            userTokenInfoList?.append(tokenInfoObject)
            
            
            userDefault.set(userTokenInfoList, forKey: USER_DEFAULT_userTokensList_Key)
        }
        
//        let tokenInfoObject = [USER_DEFAULT_tokenContractAddress_Key: tokenContractAddress, USER_DEFAULT_userID_Key: userId, USER_DEFAULT_tokenName_Key: tokenName, USER_DEFAULT_tokenBalance_Key: tokenBalance, USER_DEFAULT_tokenSymbol_Key: tokenSymbol, USER_DEFAULT_tokenPrecision_Key: tokenPrecision]
        
    }
    
    
    class func fetchImportedTokenForLoggedInUser()-> [ImportedTokenList]{
        var tokenArr = [ImportedTokenList]()

        guard let userTokenInfoList = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) as? [[String:Any]] else{
            return tokenArr
        }

        for dict in userTokenInfoList{
            if let tokenInfo = ImportedTokenList(dict: dict){
                tokenArr.append(tokenInfo)
            }
        }
        
        print("tokenArr....", tokenArr)
        return tokenArr
    }
    
    
}
