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
    
    
    
    
    init(dict:[String:Any]){
        msg = dict["msg"] as? String
        groupId = dict["groupId"] as? String
        receiverId = dict["receiverId"] as? String
        senderPbKey = dict["senderPbKey"] as? String
        mediaId = dict["mediaId"] as? String
        enKey = dict["enKey"] as? String
        quoteMsgId = dict["quoteMsgId"] as? String
        msgType = dict["msgType"] as? Int
    }
    
    init(msg:String,groupId:String?,receiverId:String?,senderPbKey:String?,mediaId:String?,enKey:String?,quoteMsgId:String?,msgType:Int?){
        self.msg = msg
        self.groupId = groupId
        self.receiverId = receiverId
        self.senderPbKey = senderPbKey
        self.mediaId = mediaId
        self.enKey = enKey
        self.quoteMsgId = quoteMsgId
        self.msgType = msgType
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


enum MessageType:Int{
    case Text = 1
    case Picture = 2
    case Video = 3
    case Voice = 4
    case Reward = 5
    case QuotedMessage = 6
    case Notification = 7
    case File = 8
}
