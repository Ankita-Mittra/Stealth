//
//  SendMessageRequest.swift
//  Stealth777
//
//  Created by Manpreet Singh on 02/08/2022.
//

import Foundation
struct SendMessageRequest{
    var msg:String?
    var groupId:String?
    var receiverId:String?
    var senderPbKey:String?
    var mediaId:String?
    var enKey:String?
    var quoteMsgId:String?
    var msgType:Int?
    
    init(){
        
    }
    
    func toDictionary() -> [String:Any]{
        let dict:[String:Any] = ["msg":msg ?? "",
                    "groupId":groupId ?? "",
                    "receiverId":receiverId ?? "",
                    "senderPbKey":senderPbKey ?? "",
                    "mediaId":mediaId ?? "",
                    "enKey":enKey ?? "",
                    "quoteMsgId":quoteMsgId ?? "",
                    "msgType":msgType ?? 0]
        return dict
        
    }
    
   
}
