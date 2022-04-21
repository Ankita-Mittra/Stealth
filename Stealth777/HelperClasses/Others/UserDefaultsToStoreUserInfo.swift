//
//  UserDefaults.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/04/2022.
//

import UIKit

class UserDefaultsToStoreUserInfo: NSObject {

    // Method to save userInfo(private and public key, userId, token) locally
    func saveUserDataInUserDefaults(token: String, userId: String, publicKey: String, privateKey: String){
        
        var userInfo: [[String: Any]] = []
        userInfo.append([USER_DEFAULT_token_Key: token, USER_DEFAULT_userID_Key: userId, USER_DEFAULT_privateKey_Key: privateKey, USER_DEFAULT_publicKey_Key: publicKey])
        print("userInfo....", userInfo)

        userDefault.set(userInfo, forKey: USER_DEFAULT_userInfo_Key)
    }
    
    
    
    
}
