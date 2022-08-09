//
//  MuteUserRequest.swift
//  Stealth777
//
//  Created by Manpreet Singh on 05/08/2022.
//

import Foundation

struct MuteUserRequest{
    var mute:Int?
    var userId:String?
    var groupId:String?
    var receiverType:Int?
    
    init(mute:Int,userId:String,groupId:String,receiverType:Int){
        self.mute = mute
        self.userId = userId
        self.receiverType = receiverType
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["mute":mute ?? 0,
                    "userId":userId ?? "",
                    "groupId":groupId ?? "",
                    "receiverType":receiverType ?? 0]
        return dict
    }
    
    
}
