//
//  GroupMembersModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 07/06/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


struct GroupMembersModel {
    
    let id: String? // 1
    let username: String? // 2
    let imageUrl: String? // 3
    let bio: String? // 4
    let groupRole: Int? // 5
    let userType: Int? // 6
    let thumbUrl:String?

    init(with data: [String: Any]?) {

        self.id = data?["id"] as? String ?? emptyStr
        self.username = data?["username"] as? String ?? emptyStr
        self.imageUrl = data?["imageUrl"] as? String ?? emptyStr
        self.bio = data?["bio"] as? String ?? emptyStr
        self.userType = data?["userType"] as? Int ?? zero
        self.groupRole = data?["groupRole"] as? Int ?? zero
        self.thumbUrl = data?["thumbUrl"] as? String ?? ""
    }
    
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.username = json["username"].stringValue
        self.imageUrl = json["imageUrl"].stringValue
        self.bio = json["bio"].stringValue
        self.userType = json["userType"].intValue
        self.groupRole = json["groupRole"].intValue
        self.thumbUrl = json["thumbUrl"].stringValue
        
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
        self.thumbUrl = dataMappingFromGroupParticipants?.thumbUrl
//        self.id = dataMapping?["id"] as? String ?? emptyStr
//        self.username = dataMapping?["username"] as? String ?? emptyStr
//        self.imageUrl = dataMapping?["imageUrl"] as? String ?? emptyStr
//        self.bio = dataMapping?["bio"] as? String ?? emptyStr
//        self.userType = dataMapping?["userType"] as? Int ?? zero
//        self.groupRole = dataMapping?["groupRole"] as? Int ?? zero
    }
    
    //intialise using local db object for group member
     init(with obj:GroupMembers){
         self.id = obj.userId
         self.username = obj.username
         self.imageUrl = obj.imgUrl
         self.bio = obj.bio
         self.userType = Int(obj.userType)
         self.groupRole = Int(obj.groupRole)
         self.thumbUrl = obj.thumbUrl
        
    }
   

}
