//
//  GroupsModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 26/05/2022.
//

import Foundation
import Alamofire

struct GroupsModel: Codable {
    
    let id: String? // 1
    let name: String? // 2
    let description: String? // 4
    let imageUrl: String? // 5
    let disperse: Int? // 6
    let anonymous: Int? // 7
    let disperseDate: String? // 8
    let canSendMsg: Int? // 9
    let showQr: Int? // 10
    let isPin: Int? // 11
    let isMute: Int? // 12
    let groupRole: Int? // 13
    var members: [GroupMembersModel]? // 15

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
        self.members = []
//        self.members = data?["members"] as? [GroupMembersModel] ?? []
        if let users = data?["members"] as? [[String: Any]]{
            for user in users{
                let member = GroupMembersModel(with: user)
                self.members?.append(member)
            }
        }
        

    }
    
    
    

}
