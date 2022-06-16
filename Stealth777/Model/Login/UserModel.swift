//
//  UserModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//

import Foundation
import Alamofire

struct UserModel: Codable {

    let userId: String? // 1
    let username: String? // 2
    let userType: Int? // 3
    let bio: String? // 4
    let imageUrl: String? // 5
    let isMute: Int? // 6
    let isBlock: Int? // 7
    let isPin: Int? // 8
    let allowWipeout: Int? // 9
    let onlineStatus: Int? // 10
    let lastOnlineTime: String? // 11
    let walletKey: String? // 12
    let relation: Int? // 13
    let publicKey: String? // 14
    let accountStatus: Int? // 15

//    enum CodingKeys: String, CodingKey {
//        case userId = "id"
//        case username = "username"
//        case userType = "userType"
//        case imageUrl = "imageUrl"
//        case bio = "bio"
//        case isMute = "isMute"
//        case isBlock = "isBlock"
//        case isPin = "isPin"
//        case allowWipeout = "allowWipeOut"
//        case onlineStatus = "onlineStatus"
//        case lastOnlineTime = "lastOnlineTime"
//        case walletKey = "wKey"
//        case relation = "relation"
//        case publicKey = "pbKey"
//        case accountStatus = "accountState"
//    }
//
    init(userId: String, username: String, userType: Int, bio: String, imageUrl: String, isMute: Int, isBlock: Int, isPin: Int, allowWipeout: Int, onlineStatus: Int, lastOnlineTime: String, walletKey: String, relation: Int, publicKey: String, accountStatus: Int){
        self.userId = userId
        self.username = username
        self.userType = userType
        self.bio = bio
        self.imageUrl = imageUrl
        self.isMute = isMute
        self.isBlock = isBlock
        self.isPin = isPin
        self.allowWipeout = allowWipeout
        self.onlineStatus = onlineStatus
        self.lastOnlineTime = lastOnlineTime
        self.walletKey = walletKey
        self.relation = relation
        self.publicKey = publicKey
        self.accountStatus = accountStatus
    }
//
//    init?(dict: [String:Any]) {
//        guard
//            let userId = dict["id"] as? String,
//            let username = dict["username"] as? String,
//            let userType = dict["userType"] as? Int,
//            let bio = dict["bio"] as? String,
//            let imageUrl = dict["imageUrl"] as? String,
//            let isMute = dict["isMute"] as? Int,
//            let isBlock = dict["isBlock"] as? Int,
//            let isPin = dict["isPin"] as? Int,
//            let allowWipeout = dict["allowWipeOut"] as? Int,
//            let onlineStatus = dict["onlineStatus"] as? Int,
//            let lastOnlineTime = dict["lastOnlineTime"] as? String,
//            let walletKey = dict["wKey"] as? String,
//            let relation = dict["relation"] as? Int,
//            let publicKey = dict["pbKey"] as? String,
//            let accountStatus = dict["accountState"] as? Int else {
//                    return nil
//            }
//        
//        self.username = username
//        self.userId = userId
//        self.userType = userType
//        self.bio = bio
//        self.imageUrl = imageUrl
//        self.isMute = isMute
//        self.isPin = isPin
//        self.isBlock = isBlock
//        self.allowWipeout = allowWipeout
//        self.onlineStatus = onlineStatus
//        self.lastOnlineTime = lastOnlineTime
//        self.walletKey = walletKey
//        self.relation = relation
//        self.publicKey = publicKey
//        self.accountStatus = accountStatus
//    }

    init(with data: [String: Any]?) {

        self.userId = data?["id"] as? String ?? emptyStr
        self.username = data?["username"] as? String ?? emptyStr
        self.imageUrl = data?["imageUrl"] as? String ?? emptyStr
        self.bio = data?["bio"] as? String ?? emptyStr
        self.userType = data?["userType"] as? Int ?? zero
        self.isMute = data?["isMute"] as? Int ?? zero
        self.isPin = data?["isPin"] as? Int ?? zero
        self.isBlock = data?["isBlock"] as? Int ?? zero
        self.allowWipeout = data?["allowWipeOut"] as? Int ?? zero
        self.onlineStatus = data?["onlineStatus"] as? Int ?? zero

        self.lastOnlineTime = data?["lastOnlineTime"] as? String ?? emptyStr
        self.publicKey = data?["pbKey"] as? String ?? emptyStr
        self.walletKey = data?["wKey"] as? String ?? emptyStr
        self.relation = data?["relation"] as? Int ?? zero
        self.accountStatus = data?["accountState"] as? Int ?? zero

    }
    
    init(with data:User?) {
        
        self.userId = data?.id
        self.username = data?.username
        self.imageUrl = data?.imgUrl
        self.bio = data?.bio
        self.userType = Int(data?.userType ?? 0)
        self.isMute = Int(data?.isMute ?? 0)
        self.isPin = Int(data?.isPin ?? 0)
        self.isBlock = Int(data?.isBlock ?? 0)
        self.allowWipeout = Int(data?.allowWipeout ?? 0)
        self.onlineStatus = Int(data?.onlineStatus ?? 0)
        self.lastOnlineTime = ""//data?.lastOnlineTime as String
        self.publicKey = data?.pbKey
        self.walletKey = data?.wKey
        self.relation = 0
        self.accountStatus = Int(data?.accStatus ?? 0)

    }
    
    func toAnyObject() -> Any {
        return [
            "id" : userId,
            "username": username,
            "imageUrl": imageUrl,
            "bio": bio,
            "userType": userType,
            "isMute": isMute,
            "isPin": isPin,
            "isBlock": isBlock,
            "allowWipeOut": allowWipeout,
            "onlineStatus": onlineStatus,
            "lastOnlineTime": lastOnlineTime,
            "pbKey": publicKey,
            "wKey": walletKey,
            "relation": relation,
            "accountState": accountStatus
        ]
    }
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        userId = try values.decodeIfPresent(String.self, forKey: .userId) ?? emptyStr
//        username = try values.decodeIfPresent(String.self, forKey: .username) ?? emptyStr
//        bio = try values.decodeIfPresent(String.self, forKey: .bio) ?? emptyStr
//        userType = try values.decodeIfPresent(Int.self, forKey: .userType) ?? zero
//        imageUrl = try values.decodeIfPresent(String.self, forKey: .imageUrl) ?? emptyStr
//        isMute = try values.decodeIfPresent(Int.self, forKey: .isMute) ?? zero
//        isBlock = try values.decodeIfPresent(Int.self, forKey: .isBlock) ?? zero
//        isPin = try values.decodeIfPresent(Int.self, forKey: .isPin) ?? zero
//        allowWipeout = try values.decodeIfPresent(Int.self, forKey: .allowWipeout) ?? zero
//        onlineStatus = try values.decodeIfPresent(Int.self, forKey: .onlineStatus) ?? zero
//        lastOnlineTime = try values.decodeIfPresent(String.self, forKey: .lastOnlineTime) ?? emptyStr
//        walletKey = try values.decodeIfPresent(String.self, forKey: .walletKey) ?? emptyStr
//        publicKey = try values.decodeIfPresent(String.self, forKey: .publicKey) ?? emptyStr
//        relation = try values.decodeIfPresent(Int.self, forKey: .relation) ?? zero
//        accountStatus = try values.decodeIfPresent(Int.self, forKey: .accountStatus) ?? zero
//    }


}
