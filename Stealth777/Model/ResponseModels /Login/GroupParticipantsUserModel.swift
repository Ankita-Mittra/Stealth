//
//  GroupParticipantsUserModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/06/2022.
//

import Foundation
import Alamofire

struct GroupParticipantsUserModel: Codable {

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
    let wKey: String? // 12
    let relation: Int? // 13
    let publicKey: String? // 14
    let accountStatus: Int? // 15
    let isSelected: Int?
    let thumbUrl:String?
    
    init(userId: String, username: String, userType: Int, bio: String, imageUrl: String, isMute: Int, isBlock: Int, isPin: Int, allowWipeout: Int, onlineStatus: Int, lastOnlineTime: String, wKey: String, relation: Int, publicKey: String, accountStatus: Int, isSelected: Int,thumbUrl:String){
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
        self.wKey = wKey
        self.relation = relation
        self.publicKey = publicKey
        self.accountStatus = accountStatus
        self.isSelected = isSelected
        self.thumbUrl = thumbUrl
    }

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
        self.wKey = data?["wKey"] as? String ?? emptyStr
        self.relation = data?["relation"] as? Int ?? zero
        self.accountStatus = data?["accountState"] as? Int ?? zero
        self.isSelected = data?["isSelected"] as? Int ?? zero
        self.thumbUrl = data?["thumbUrl"] as? String
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
        self.wKey = data?.wKey
        self.relation = 0
        self.accountStatus = Int(data?.accStatus ?? 0)
        self.isSelected = 0
        self.thumbUrl = data?.thumbUrl
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
            "wKey": wKey,
            "relation": relation,
            "accountState": accountStatus,
            "isSelected" : isSelected,
            "thumbUrl":thumbUrl ?? ""
        ]
    }
    
    

}
