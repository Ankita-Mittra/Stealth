//
//  MessageModel.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 25, 2022
//

import Foundation
import SwiftyJSON

struct MessageModel {

	let msgId: String?
	let groupId: String?
	let senderName: String?
	let msg: MessageContent?
	let quoteMsgId: String?
	let quoteMsg: QuoteMessage?
	let enKey: String?
	let senderPbKey: String?
	let state: Int?
	let senderId: String?
	let receiverId: String?
	let imgUrl: String?
	let msgType: Int?
	let readTime: Int64?
	let sendTime: Int64?

	init(_ json: JSON) {
		msgId = json["msgId"].stringValue
        groupId = json["groupId"].stringValue
		senderName = json["senderName"].stringValue
		msg = MessageContent(json["msg"])
		quoteMsgId = json["quoteMsgId"].stringValue
		quoteMsg = QuoteMessage(json["quoteMsg"])
		enKey = json["enKey"].stringValue
		senderPbKey = json["senderPbKey"].stringValue
		state = json["state"].intValue
		senderId = json["senderId"].stringValue
		receiverId = json["receiverId"].stringValue
		imgUrl = json["imgUrl"].stringValue
		msgType = json["msgType"].intValue
		readTime = json["readTime"].int64Value
		sendTime = json["sendTime"].int64Value
	}
    
    init(msgId:String,groupId:String,senderName:String,msgDict:[String:Any],quoteMsgId:String,quoteMsgDict:[String:Any],enKey:String,senderPbKey:String,state:Int,senderId:String,receiverId:String,imgUrl:String,msgType:Int,readTime:Int64,sendTime:Int64){
        
        self.msgId = msgId
        self.groupId = groupId
        self.senderName = senderName
        self.msg = MessageContent(JSON(msgDict))
        self.quoteMsgId = quoteMsgId
        self.quoteMsg = QuoteMessage(JSON(quoteMsgDict))
        self.enKey = enKey
        self.senderPbKey = senderPbKey
        self.state = state
        self.senderId = senderId
        self.receiverId = receiverId
        self.imgUrl = imgUrl
        self.msgType = msgType
        self.readTime = readTime
        self.sendTime = sendTime
        
    }
    
    init(message:Messages){
        msgId = message.msgId
        groupId = message.groupId
        senderName = message.groupId
        msg = MessageContent(CommonFxns.getJsonObject(strJson: message.msg ?? ""))
        quoteMsgId = message.quoteMsgId
        quoteMsg = QuoteMessage(CommonFxns.getJsonObject(strJson: message.quoteMsg ?? ""))
        enKey = message.enKey
        senderPbKey = message.senderPbKey
        state = Int(message.state)
        senderId = message.senderId
        receiverId = message.receiverId
        imgUrl = message.senderImgUrl
        msgType = Int(message.msgType)
        readTime = message.readTime
        sendTime =  message.sendTime
    }

}
