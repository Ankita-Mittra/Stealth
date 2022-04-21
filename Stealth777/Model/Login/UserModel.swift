//
//  UserModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//

import Foundation
import Alamofire




struct UserModel: Codable {

    let userId: String?
    let username: String?
    let userType: Int?
    let bio: String?
    let imageUrl: String?
    let isMute: Int?
    let isBlock: Int?
    let isPin: Int?
    let allowWipeout: Int?
    let status: Int?
    let onlineStatus: Int?
    let lastOnlineTime: String?

    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case username = "username"
        case userType = "userType"
        case imageUrl = "imageUrl"
        case bio = "bio"
        case isMute = "isMute"
        case isBlock = "isBlock"
        case isPin = "isPin"
        case allowWipeout = "allowWipeOut"
        case status = "status"
        case onlineStatus = "onlineStatus"
        case lastOnlineTime = "lastOnlineTime"
    }
    
    init(userId: String, username: String, userType: Int, bio: String, imageUrl: String, isMute: Int, isBlock: Int, isPin: Int, allowWipeout: Int, status: Int, onlineStatus: Int, lastOnlineTime: String){
        self.userId = userId
        self.username = username
        self.userType = userType
        self.bio = bio
        self.imageUrl = imageUrl
        self.isMute = isMute
        self.isBlock = isBlock
        self.isPin = isPin
        self.allowWipeout = allowWipeout
        self.status = status
        self.onlineStatus = onlineStatus
        self.lastOnlineTime = lastOnlineTime
    }
    
    
}
