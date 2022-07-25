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
	let readTime: String?
	let sendTime: String?

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
		readTime = json["readTime"].stringValue
		sendTime = json["sendTime"].stringValue
	}

}
