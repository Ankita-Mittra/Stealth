//
//  StringsForCode.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/02/2022.
//

import Foundation
import UIKit
import SwiftUI

// All the strings using for app code
// MARK: - App mains
let appName = "Stealth777"
var baseUrl = "https://stealth777.is/"//"https://185.247.226.7./api/users/register"//"https://jsonplaceholder.typicode.com/todos/" 

let coreDataName = "Stealth777"

// MARK: - Common

let usernamePrefix = "777"

let emptyStr = ""

let lightMode = "light"
let darkMode = "dark"

// MARK: - Enum_StoryBoard

enum enumViewControllerIdentifier: String {
    
//    case privateModeTabBar = "PrivateModeTabBarViewController"
    case publicModeTabBar = "PublicModeTabBarViewController"

    case importWallet = "ImportWalletViewController"
    case enterUsername = "EnterUsernameViewController"
    case login = "LoginViewController"
    case enterPassword = "EnterPasswordViewController"
    case createWallet = "CreateWalletViewController"
    case home = "HomeViewController"
    case contacts = "ContactsViewController"
    case resetPassword = "ResetPasswordViewController"
    case recoverPassword = "RecoverPasswordViewController"    
    case initial = "InitialViewController"
    case privateChat = "PrivateChatViewController"
    case groupChat = "GroupChatViewController"
    case userProfile = "UserProfileViewController"
    case otherUserProfile = "OtherUserProfileViewController"
    case termsAndConditions = "TermsAndConditionsViewController"
    case groupDetails = "GroupDetailsViewController"
    case groupSettings = "GroupSettingsViewController"
    case notifications = "NotificationsViewController"
    case allGroups = "AllGroupsViewController"
    case requests = "RequestsViewController"
    case settings = "SettingsViewController"
    case accountSettings = "AccountSettingsViewController"
    case generalSettings = "GeneralSettingsViewController"
    case securitySettings = "SecuritySettingsViewController"
    case callLogs = "CallLogsViewController"
    
    case sendFunds = "SendFundsViewController"
    case transferAmount = "TransferAmountViewController"
    case sendingAmount = "SendingAmountViewController"
    case receiveAmount = "ReceiveAmountViewController"
    case walletList = "WalletListViewController"
    case importNewWallet = "ImportNewWalletViewController"
    case transactionsHistory = "TransactionsHistoryViewController"
    case importToken = "ImportTokenViewController"
    case walletDetails = "WalletDetailsViewController"
    case allContactsList = "AllContactsListViewController"
    case searchUsers = "SearchUsersViewController"
    case privateChatUserProfile = "PrivateChatUserProfileViewController"
    case createGroup = "CreateGroupViewController"

    case userInfo = "UserInfoViewController"
    case subscribeNow = "SubscribeNowViewController"
    case checkOut = "CheckOutViewController"
    case subscriptionDetails = "SubscriptionDetailsViewController"
    
}

enum enumStoryBoard:String {
    case main = "Main"
    case home = "RecoverPasswordStoryboard"
//    case privateTabBarController = "PrivateModeTabBarControllerStoryboard"
    case publicModeTabBarController = "PublicModeTabBarControllerStoryboard"

    case login = "LoginStoryboard"
    case enterUsername = "EnterUsernameStoryboard"
    case enterPassword = "EnterPasswordStoryboard"
    case importWallet = "ImportWalletStoryboard"
    case createWallet = "CreateWalletStoryboard"
    case settings = "SettingsStoryboard"
    case notifications = "NotificationsStoryboard"
    case privateChat = "PrivateChatStoryboard"
    case groupChat = "GroupChatStoryboard"
    case wallet = "WalletStoryboard"
    case contacts = "ContactsStoryboard"
    case calls = "CallsStoryboard"
    case profile = "ProfileStoryboard"
    case subscribe = "SubscriptionStoryboard"

}

enum APIKeysForUser: String{
    
    case username_key = "username"
    
    case imageUrl_key = "imageUrl"
    
    case publicKey_key = "pbKey"
    
    case userType_key = "usertype"

    case deviceNo_key = "deviceNo"
    
    case deviceName_key = "deviceName"
    
    case deviceVersion_key = "deviceVersion"
    
    case platform_key = "platform"
    
    case walletPhrase = "wPhrase"
    
    case walletId_key = "walletKey"
    
    case password_key = "password"

    case id_key = "id"
        
    case status_key = "status"

    case remark_key = "remark"
    
    case userId_key = "userId"

}

enum APIKeysForGroup: String{
    case name_key = "name"
    
    case disperse_key = "disperse"
    
    case description_key = "description"
    
    case anonymous_key = "anonymous"
    
    case user_ids_key = "user_ids"
    
    case type_key = "type"
    
    case imageUrl_key = "mediaId"
        
}


enum APICommonKeys: String{
    
    case success_key = "success"
    
    case code_key = "code"
    
    case message_key = "message"
    
    case version_key = "version"
    
    case data_key = "data"
    
    case token_key = "token"

}

