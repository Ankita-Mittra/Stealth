//
//  ListMessageRequest.swift
//  Stealth777
//
//  Created by Manpreet Singh on 03/08/2022.
//

import Foundation

struct ListMessageRequest{
    var groupId:String?
    var receiverId:String?
    
    init(groupId:String?,receiverId:String?){
        self.groupId = groupId
        self.receiverId = receiverId
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["groupId":groupId ?? "",
                    "receiverId":receiverId ?? ""]
        return dict
    }
}
