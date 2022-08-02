//
//  Constants.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/02/2022.
//

import Foundation
import UIKit

// All the app costants using in code

// MARK: AppDelegate reference
let appDelegate = UIApplication.shared.delegate as!(AppDelegate)

// MARK: - UserDefault Constants

let userDefault = UserDefaults.standard

// User default Keys
// User info
let USER_DEFAULT_userInfo_Key = "userDefault_userInfo"

//let USER_DEFAULT_username_Key = "userDefault_username"
let USER_DEFAULT_walletAddress_Key = "userDefault_walletAddress"
let USER_DEFAULT_userID_Key = "userDefault_userID"
let USER_DEFAULT_userDetails_Key = "userDefault_userDetails"
let USER_DEFAULT_token_Key = "userDefault_token"

let USER_DEFAULT_privateKey_Key = "userDefault_privateKey"
let USER_DEFAULT_publicKey_Key = "userDefault_publicKey"

//let USER_DEFAULT_imageUrl_Key = "userDefault_imageUrl"
//let USER_DEFAULT_bio_Key = "userDefault_bio"

let USER_DEFAULT_userTokensList_Key = "userDefault_userTokensList"

let USER_DEFAULT_tokenContractAddress_Key = "userDefault_tokenContractAddress"
let USER_DEFAULT_tokenSymbol_Key = "userDefault_tokenSymbol"
let USER_DEFAULT_tokenBalance_Key = "userDefault_tokenBalance"
let USER_DEFAULT_tokenPrecision_Key = "userDefault_tokenPrecision"
let USER_DEFAULT_tokenName_Key = "userDefault_tokenName"

// Other Settings
let USER_DEFAULT_isDarkMode_Key = "userDefault_isDarkMode"

// MARK: - Local DB keys

let messages_localDB = "Messages"
// MARK: iPhone device's size Constants

// OS type
let iOSDeviceType = 1
let appVersion = 1.8

// MARK: - Others

let userType = 1 // 0: Private, 1: Public
let platform = "ios"

// Screen sizes
let iPhone_8Plus_Height:CGFloat = 736
let iPhone_X_Height:CGFloat = 812
let iPhone_6_Height:CGFloat = 667
let iPhone_13Pro_MAX_Height:CGFloat = 926
let iPhone_11Pro_MAX_Height:CGFloat = 896

// Numbers
let defaultIntValue = 0
let zero = 0
let one = 1
let two = 2
let five = 5

//Group States
enum enumGroupState:Int{
    case active = 1
    case exit = 2
    case delete = 3
    
}

// Fonts increment/decrement

//let fontSizeForLargeDevices:CGFloat = 2
//let fontSizeForSmallDevices:CGFloat = 2
let fontSizeDifferenceForSmallDevices:CGFloat = 3
let fontSizeDifferenceForMediumDevices:CGFloat = 2

// MARK: Colors

let usernameAlertBgGreenColor = UIColor(red: 69/250, green: 191/250, blue: 85/250, alpha: 1)

// Constants for code


let friends = 2
let pendingRequest = 1
let noRelation = 0

let acceptFriendRequest = 1
let rejectFriendRequest = 0

let acceptGroupRequest = 1
let rejectGroupRequest = 0
