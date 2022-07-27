//
//  UserDefaults.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/04/2022.
//

import UIKit

class UserDefaultsToStoreUserInfo: NSObject {

    // Method to save userInfo(private and public key, userId, token) locally
    class func saveUserDataInUserDefaults(token: String, userId: String, publicKey: String, privateKey: String, walletAddress: String, userDetails: [String: Any]){
        
        var userInfo: [String: Any] = [:]
        
        userInfo = [USER_DEFAULT_token_Key: token, USER_DEFAULT_userID_Key: userId, USER_DEFAULT_privateKey_Key: privateKey, USER_DEFAULT_publicKey_Key: publicKey, USER_DEFAULT_walletAddress_Key: walletAddress, USER_DEFAULT_userDetails_Key: userDetails ]
        
        print("userInfo....", userInfo)

        userDefault.set(userInfo, forKey: USER_DEFAULT_userInfo_Key)
        
        print("token....", token)
        userDefault.set(token, forKey: USER_DEFAULT_token_Key)
    }
    
    class func getuserID()->String{
        if let userInfo = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String:Any]{
            if let id = userInfo[USER_DEFAULT_userID_Key] as? String{
                return id
            }
        }
        return ""
    }
    
//    class func saveImportedTokenForLoggedInUser1(tokenContractAddress: String, userId: String, tokenName: String, tokenSymbol: String, tokenBalance: String, tokenPrecision: String){
//
//        var emptySet = Set<T>()
//
//        if let tokenInfoObject = ImportedTokenList(name: tokenName, symbol: tokenSymbol, decimals: tokenPrecision, balance: tokenBalance, contractAddress: tokenContractAddress).toAnyObject() as? [String : Any]{
//
//            print("tokenInfoObject....", tokenInfoObject)
//
//            userTokenInfoList.append(tokenInfoObject)
//            userDefault.set(userTokenInfoList, forKey: USER_DEFAULT_userTokensList_Key)
//        }
//
////        let tokenInfoObject = [USER_DEFAULT_tokenContractAddress_Key: tokenContractAddress, USER_DEFAULT_userID_Key: userId, USER_DEFAULT_tokenName_Key: tokenName, USER_DEFAULT_tokenBalance_Key: tokenBalance, USER_DEFAULT_tokenSymbol_Key: tokenSymbol, USER_DEFAULT_tokenPrecision_Key: tokenPrecision]
//
//    }
    
    class func saveImportedTokenForLoggedInUser(tokenInfoDict: ImportedTokenList){
        
        var userTokenInfoList = [[String:Any]]()

        var alreadyExisted = false
        
        if let tokenArr = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) as? [[String: Any]]{
                        
            if let foundDict = tokenArr.first(where: {$0[USER_DEFAULT_tokenContractAddress_Key] as? String == tokenInfoDict.contractAddress}) {
                
                print("foundDict", foundDict)
                alreadyExisted = true
            }
            print("tokenArr....", tokenArr)
            userTokenInfoList.append(contentsOf: tokenArr)
        }

        print("alreadyExisted...", alreadyExisted)
        if !alreadyExisted{
            if let dict = tokenInfoDict.toAnyObject() as? [String : Any] {
                userTokenInfoList.append(dict)
                print("step 2")
                print("tokenInfoObject....", dict)

                userDefault.set(userTokenInfoList, forKey: USER_DEFAULT_userTokensList_Key)
            }
        }
    }
    
    
    
    
//    class func saveImportedTokenForLoggedInUser(tokenContractAddress: String, userId: String, tokenName: String, tokenSymbol: String, tokenBalance: String, tokenPrecision: String){
//
//        var userTokenInfoList = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) as? [[String:Any]]
//
//
//        if let tokenInfoObject = ImportedTokenList(name: tokenName, symbol: tokenSymbol, decimals: tokenPrecision, balance: tokenBalance, contractAddress: tokenContractAddress).toAnyObject() as? [String : Any]{
//
//            print("tokenInfoObject....", tokenInfoObject)
//
//    /Users/armoneydupink/Documents/Workspace/AppStore/Stealth777/Stealth777/Modules/MY LIFE//            userTokenInfoList?.append(tokenInfoObject)
//
//
//            userDefault.set(userTokenInfoList, forKey: USER_DEFAULT_userTokensList_Key)
//        }
//
////        let tokenInfoObject = [USER_DEFAULT_tokenContractAddress_Key: tokenContractAddress, USER_DEFAULT_userID_Key: userId, USER_DEFAULT_tokenName_Key: tokenName, USER_DEFAULT_tokenBalance_Key: tokenBalance, USER_DEFAULT_tokenSymbol_Key: tokenSymbol, USER_DEFAULT_tokenPrecision_Key: tokenPrecision]
//
//    }
//
    
    class func fetchImportedTokenForLoggedInUser()-> [ImportedTokenList]{
        var tokenArr = [ImportedTokenList]()

        print("step 3")
        
        guard let userTokenInfoList = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) else{
            return tokenArr
        }
        print("step 4...", userTokenInfoList)
    
        if let arr = userTokenInfoList as? [[String: Any]]{
            
            print("step 5")

            for dict in arr{
                if let tokenInfo = ImportedTokenList(dict: dict){
                    tokenArr.append(tokenInfo)
                }
            }
        }

        
        
        print("tokenArr....", tokenArr)
        return tokenArr
    }
    
    
}
