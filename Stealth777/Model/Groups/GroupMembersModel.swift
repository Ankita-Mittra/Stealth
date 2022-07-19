//
//  GroupMembersModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 07/06/2022.
//

import Foundation
import Alamofire

struct GroupMembersModel: Codable {
    
    let id: String? // 1
    let username: String? // 2
    let imageUrl: String? // 3
    let bio: String? // 4
    let groupRole: Int? // 5
    let userType: Int? // 6

    init(with data: [String: Any]?) {

        self.id = data?["id"] as? String ?? emptyStr
        self.username = data?["username"] as? String ?? emptyStr
        self.imageUrl = data?["imageUrl"] as? String ?? emptyStr
        self.bio = data?["bio"] as? String ?? emptyStr
        self.userType = data?["userType"] as? Int ?? zero
        self.groupRole = data?["groupRole"] as? Int ?? zero
    }
    
//    
//    init(with dataUsername: [String: Any]?) {
//
//        self.id = dataUsername?["id"] as? String ?? emptyStr
//        self.username = dataUsername?["username"] as? String ?? emptyStr
//        self.imageUrl = dataUsername?["imageUrl"] as? String ?? emptyStr
//        self.bio = dataUsername?["bio"] as? String ?? emptyStr
//        self.userType = dataUsername?["userType"] as? Int ?? zero
//        self.groupRole = dataUsername?["groupRole"] as? Int ?? zero
//    }
//    
    
    
    init(with dataMappingFromGroupParticipants: GroupParticipantsUserModel?) {

        self.id = dataMappingFromGroupParticipants?.userId
        self.username = dataMappingFromGroupParticipants?.username
        self.imageUrl = dataMappingFromGroupParticipants?.imageUrl
        self.bio = dataMappingFromGroupParticipants?.bio
        self.userType = dataMappingFromGroupParticipants?.userType
        self.groupRole = 1
//        self.id = dataMapping?["id"] as? String ?? emptyStr
//        self.username = dataMapping?["username"] as? String ?? emptyStr
//        self.imageUrl = dataMapping?["imageUrl"] as? String ?? emptyStr
//        self.bio = dataMapping?["bio"] as? String ?? emptyStr
//        self.userType = dataMapping?["userType"] as? Int ?? zero
//        self.groupRole = dataMapping?["groupRole"] as? Int ?? zero
    }


}