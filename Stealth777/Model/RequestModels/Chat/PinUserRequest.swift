//
//  PinUserRequest.swift
//  Stealth777
//
//  Created by Manpreet Singh on 05/08/2022.
//

import Foundation

struct PinUserRequest{
    var pin:Int?
    var userId:String?
    var groupId:String?
    var receiverType:Int?
    
    init(pin:Int,userId:String?,groupId:String?,receiverType:Int){
        self.pin = pin
        self.userId = userId
        self.groupId = groupId
        self.receiverType = receiverType
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["pin":pin ?? 0,
                    "userId":userId ?? "",
                    "groupId":groupId ?? "",
                    "receiverType":receiverType ?? 0]
        return dict
    }
    
}
