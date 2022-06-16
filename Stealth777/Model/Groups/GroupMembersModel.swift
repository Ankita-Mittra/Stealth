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
        self.username = data?["userName"] as? String ?? emptyStr
        self.imageUrl = data?["imageUrl"] as? String ?? emptyStr
        self.bio = data?["bio"] as? String ?? emptyStr
        self.userType = data?["userType"] as? Int ?? zero
        self.groupRole = data?["groupRole"] as? Int ?? zero
    }
    
    
    

}
