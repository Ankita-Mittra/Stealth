//
//  GroupInvitaionsListModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 07/06/2022.
//


import Foundation
import SwiftyJSON

struct GroupInvitaionsListModel: Codable {
    
    let id: String? // 1
    let name: String? // 2
    let photo: String? // 4

    init(with data: [String: Any]?) {

        self.id = data?["id"] as? String ?? emptyStr
        self.name = data?["name"] as? String ?? emptyStr
        self.photo = data?["photo"] as? String ?? emptyStr
    }
    
    init(json:JSON){
        self.id = json["id"].stringValue
        self.name = json["name"].stringValue
        self.photo = json["photo"].stringValue
    }
    

}
