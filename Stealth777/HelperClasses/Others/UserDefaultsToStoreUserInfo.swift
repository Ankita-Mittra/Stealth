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
        
        userDefault.set(userInfo, forKey: USER_DEFAULT_userInfo_Key)
        userDefault.set(token, forKey: USER_DEFAULT_token_Key)
    }
    
    class func getuserID()->String{
        if let userInfo = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String:Any]{
            if let id = userInfo[USER_DEFAULT_userID_Key] as? String{
                return id
            }
        }
        return emptyStr
    }
    
    class func getUser()->UserModel?{
         if let userInfo = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String:Any]{
            if let dict = userInfo[USER_DEFAULT_userDetails_Key] as? [String:Any]{
                return UserModel(with: dict)
            }
        }
        return nil
    }
    
    class func getPrivateKeyPair()->(String, String){
         if let userInfo = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String:Any]{
            if let privateKey = userInfo[USER_DEFAULT_privateKey_Key] as? String, let publicKey = userInfo[USER_DEFAULT_publicKey_Key] as? String {
                return (privateKey, publicKey)
            }
        }
        return (emptyStr, emptyStr)
    }

    class func saveImportedTokenForLoggedInUser(tokenInfoDict: ImportedTokenList){
        
        var userTokenInfoList = [[String:Any]]()
        var alreadyExisted = false
        
        if let tokenArr = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) as? [[String: Any]]{
            if let foundDict = tokenArr.first(where: {$0[USER_DEFAULT_tokenContractAddress_Key] as? String == tokenInfoDict.contractAddress}) {
                alreadyExisted = true
            }
            userTokenInfoList.append(contentsOf: tokenArr)
        }
        if !alreadyExisted{
            if let dict = tokenInfoDict.toAnyObject() as? [String : Any] {
                userTokenInfoList.append(dict)
                userDefault.set(userTokenInfoList, forKey: USER_DEFAULT_userTokensList_Key)
            }
        }
    }
 
    class func fetchImportedTokenForLoggedInUser()-> [ImportedTokenList]{
        var tokenArr = [ImportedTokenList]()
        
        guard let userTokenInfoList = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) else{
            return tokenArr
        }
        if let arr = userTokenInfoList as? [[String: Any]]{
            for dict in arr{
                if let tokenInfo = ImportedTokenList(dict: dict){
                    tokenArr.append(tokenInfo)
                }
            }
        }
        return tokenArr
    }
    
    
}
