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
    var limit:Int?
    
    init(groupId:String?,receiverId:String?,limit:Int?){
        self.groupId = groupId
        self.receiverId = receiverId
        self.limit = limit
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["groupId":groupId ?? "",
                    "receiverId":receiverId ?? "",
                                 "limit":limit ?? 0]
        return dict
    }
}
