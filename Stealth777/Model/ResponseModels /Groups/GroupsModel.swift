//
//  GroupsModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 26/05/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

struct GroupsModel {
    
    let id: String? // 1
    let name: String? // 2
    let description: String? // 3
    let imageUrl: String? // 4
    let disperse: Int? // 5
    let anonymous: Int? // 6
    let disperseDate: String? // 7
    let canSendMsg: Int? // 8
    let showQr: Int? // 19
    let isPin: Int? // 10
    let isMute: Int? // 11
    let groupRole: Int? // 12
    var members: [GroupMembersModel]? // 13
    let thumbUrl:String?
    

    init(id: String, name: String, description: String, imageUrl: String, anonymous: Int, disperse: Int, disperseDate: String, canSendMsg: Int, showQr: Int, isPin: Int, isMute: Int, groupRole: Int, members: [GroupMembersModel],thumbUrl:String){
        self.id = id
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.disperse = disperse
        self.anonymous = anonymous
        self.disperseDate = disperseDate
        self.canSendMsg = canSendMsg
        self.showQr = showQr
        self.isPin = isPin
        self.isMute = isMute
        self.groupRole = groupRole
        self.members = members
        self.thumbUrl = thumbUrl
    }
    init(_ json: JSON) {
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.imageUrl = json["imageUrl"].stringValue
        self.description = json["desc"].stringValue
        self.disperse = json["disperse"].intValue
        self.anonymous = json["anonymous"].intValue
        self.disperseDate = json["disperseDate"].stringValue
        self.canSendMsg = json["canSendMsg"].intValue
        self.showQr = json["showQr"].intValue
        self.isPin = json["isPin"].intValue
        self.isMute = json["isMute"].intValue
        self.groupRole = json["groupRole"].intValue
        self.thumbUrl = json["thumbUrl"].stringValue
        self.members = json["members"].arrayValue.map{GroupMembersModel($0)}
        
    }
    
    init(with data: [String: Any]?) {

        self.id = data?["id"] as? String ?? emptyStr
        self.name = data?["name"] as? String ?? emptyStr
        self.imageUrl = data?["imageUrl"] as? String ?? emptyStr
        self.description = data?["desc"] as? String ?? emptyStr
        self.disperse = data?["disperse"] as? Int ?? zero
        self.anonymous = data?["anonymous"] as? Int ?? zero
        self.disperseDate = data?["disperseDate"] as? String ?? emptyStr
        self.canSendMsg = data?["canSendMsg"] as? Int ?? zero
        self.showQr = data?["showQr"] as? Int ?? zero
        self.isPin = data?["isPin"] as? Int ?? zero
        self.isMute = data?["isMute"] as? Int ?? zero
        self.groupRole = data?["groupRole"] as? Int ?? zero
        self.thumbUrl = data?["thumbUrl"] as? String
        self.members = []
//        self.members = data?["members"] as? [GroupMembersModel] ?? []
        if let users = data?["members"] as? [[String: Any]]{
            for user in users{
                let member = GroupMembersModel(with: user)
                self.members?.append(member)
            }
        }
    }
    
    //intialising with local DB object
    init(group:Groups?){
        self.id = group?.id
        self.name = group?.name
        self.description = group?.desc
        self.imageUrl = group?.imgUrl
        self.thumbUrl = group?.thumbUrl
        self.disperse = Int(group?.disperse ?? 0)
        self.anonymous = Int(group?.anonymous ?? 0)
        self.disperseDate = group?.disperseDate
        self.canSendMsg = Int( group?.sendMessage ?? 0)
        self.showQr = Int(group?.showQR ?? 0)
        self.isPin = Int(group?.isPin ?? 0)
        self.isMute = Int(group?.isMute ?? 0)
        self.groupRole = Int(group?.groupRole ?? 0)
        var membersArray = [GroupMembersModel]()
        for case let m as GroupMembers in group?.groupMembers ?? []  {
            let  obj = GroupMembersModel(with: m)
            membersArray.append(obj)
        }
        self.members = membersArray
        
    }
    
    
}
