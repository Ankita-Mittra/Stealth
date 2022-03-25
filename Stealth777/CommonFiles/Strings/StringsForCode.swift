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
// MARK: - App name
let appName = "meem"

// MARK: - Common

let usernamePrefix = "777"

//MARK:- Enum_StoryBoard

enum enumViewControllerIdentifier: String {
    
    case privateModeTabBar = "PrivateModeTabBarViewController"
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

}

enum enumStoryBoard:String {
    case main = "Main"
    case home = "RecoverPasswordStoryboard"
    case privateTabBarController = "PrivateModeTabBarControllerStoryboard"
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

//    case  = "ProfileStoryboard"

}

