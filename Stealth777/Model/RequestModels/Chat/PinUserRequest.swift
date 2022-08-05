//
//  PinUserRequest.swift
//  Stealth777
//
//  Created by Manpreet Singh on 05/08/2022.
//

import Foundation

struct PinUserRequest{
    var pin:Int?
    var chatId:String?
    var receiverType:Int?
    
    init(pin:Int,chatId:String,receiverType:Int){
        self.pin = pin
        self.chatId = chatId
        self.receiverType = receiverType
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["pin":pin ?? 0,
                    "chatId":chatId ?? "",
                    "receiverType":receiverType ?? 0]
        return dict
    }
    
}
