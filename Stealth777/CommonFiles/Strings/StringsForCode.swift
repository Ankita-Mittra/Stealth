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

let appName = "Stealth777" // App name
let coreDataName = "Stealth777" // Core database name
let baseUrl = "https://www.stealth777.is/api/"   //"https://185.247.226.7./api/users/register" // Base url for API's calls
let binanceUrl = "https://bsc-dataseed1.binance.org:443" // URL for Binance network calls

// MARK: - Common

let usernamePrefix = "777"
let emptyStr = ""

// App display mode strings
let lightMode = "light"
let darkMode = "dark"

// Groups

let createGroup = 1
let viewMembers = 2
let addMembers = 3
let showContacts = 0

// MARK: - Api's keys

let userId_API_key = "userId"
let name_API_key = "name"

// contacts


let action_API_key = "action"
let status_API_key = "status"

// groups
let groupId_API_key = "groupId"

enum enumLocalDBIdentifires : String{
    
    case users = "Users"
    case userRelation = "UserRelation"
    case messages = "Messages"
    case groupMembers = "GroupMembers"
    case groups = "Groups"
}

enum enumLocalDBUserRelationKeys : String{

 case relation = "relation"
    
}

enum enumLocalDBUserKeys : String{

 case id = "id"
    
}

// MARK: - Enum_StoryBoard

enum enumViewControllerIdentifier: String {
    
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
    case scanner = "ScannerViewController"

    case allContactsList = "AllContactsListViewController"
    case searchUsers = "SearchUsersViewController"
    case privateChatUserProfile = "PrivateChatUserProfileViewController"
    case createGroup = "CreateGroupViewController"

    case userInfo = "UserInfoViewController"
    case subscribeNow = "SubscribeNowViewController"
    case checkOut = "CheckOutViewController"
    case subscriptionDetails = "SubscriptionDetailsViewController"
    
}

enum EncryptionKeys: String {
    case publicSuffix  = "\n-----END PUBLIC KEY-----"
    case publicPrefix = "-----BEGIN PUBLIC KEY-----\n"
}

enum enumStoryBoard:String {
    case main = "Main"
    case home = "RecoverPasswordStoryboard"
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

// MARK: - NETWORK's Strings


// MARK: - End Points

enum enumAPIEndPoints: String {
    
    // MARK: - Users
    
    // Post requests
    case login = "users/login"
    case register = "users/register"

    // Get requests
    case profileInfo = "users/profile"
    case getContactsList = "users/getContactsList"
    case otherUserProfile = "users/queryUserById"
    case verifyUsername = "users/verify/"
    case logout = "users/logout"
    
    // Contacts
    case search = "users/searchContact" // name
    case sendRequest = "users/sendRequest" // userId
    case respondRequest = "users/respondRequest" // userId, action
    case getContactRequests = "users/getRequestList" // get
    case unfriendUser = "users/unFriendUser"
    // Groups
    
    case getGroupInvitations = "groups/groupInviteList" // get
    case responseInvitaions = "groups/responseInvite" // groupId, status
    case createGroup = "groups/createGroup" // groupName, mediaId, members, anonymous, disperse, disperseDate, description
    case addMembers = "groups/addMembers" // get
    case removeMembers = "groups/members/remove" // get
    case getAllGroupMembers = "groups/getMembers?groupId=" // get
    case getAllGroups = "groups/listGroup"
    case deleteGroup = "groups/messages"
    case exitGroup = "groups/leaveGroup"
    case setAdmin = "groups/setAdmin"
    
    case uploadFile = "mediaFile/upload"
    
    // Chats
    case sendMessage = "groups/sendMsg"
    case getMessageByUserID = "chat/getMsgByUserId"
    case listSession = "chat/listSession"
    case pinChat = "chat/pinChat"
    case muteUser = "chat/mute"
    case blockUser = "users/blockUser"
    case deleteChats = "chat/deleteMessages"
    
}

enum enumAPIKeysForUser: String{
    
    case username_key = "username"
    case imageUrl_key = "imageUrl"
    case publicKey_key = "pbKey"
    case userType_key = "usertype"
    case deviceNo_key = "deviceNo"
    case deviceName_key = "deviceName"
    case deviceVersion_key = "deviceVersion"
    case platform_key = "platform"
    case walletPhrase = "walletPhrase"
    case walletId_key = "walletKey"
    case password_key = "password"
    case id_key = "id"
    case status_key = "status"
    case remark_key = "remark"
    case userId_key = "userId"
    case bio_key = "bio"
    case mediaId_key = "mediaID"
    
}

enum enumAPIKeysForGroup: String{
    case groupName_key = "groupName"
    case disperse_key = "disperse"
    case description_key = "description"
    case anonymous_key = "anonymous"
    case members_key = "members"
    case disperseDate_key = "disperseDate"
    case mediaId_key = "mediaId"
}

enum enumAPICommonKeys: String{
    
    case success_key = "success"
    case code_key = "code"
    case message_key = "message"
    case version_key = "version"
    case data_key = "data"
    case token_key = "token"

}

extension String{
var localized:String{
    return NSLocalizedString(self, comment: "")
}
}
