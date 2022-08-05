//
//  MuteUserRequest.swift
//  Stealth777
//
//  Created by Manpreet Singh on 05/08/2022.
//

import Foundation

struct MuteUserRequest{
    var mute:Int?
    var chatId:String?
    var receiverType:Int?
    
    init(mute:Int,chatId:String,receiverType:Int){
        self.mute = mute
        self.chatId = chatId
        self.receiverType = receiverType
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["mute":mute ?? 0,
                    "chatId":chatId ?? "",
                    "receiverType":receiverType ?? 0]
        return dict
    }
    
    
}
