//
//  SessionList.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 25, 2022
//
import Foundation
import SwiftyJSON

struct SessionList {

	let msgId: String?
	let groupId: String?
	let senderId: String?
	let receiverId: String?
	let sendTime: Double?
	let msgType: Int?
	let msg: Msg?
	let username: String?
	let imgUrl: String?
	let isPin: Int?
	let isMute: Int?
	let senderPbKey: String?
	let enKey: String?
	let state: Int?
	let unreadCount: Int?

	init(_ json: JSON) {
		msgId = json["msgId"].stringValue
		groupId = json["groupId"].stringValue
		senderId = json["senderId"].stringValue
		receiverId = json["receiverId"].stringValue
		sendTime = json["sendTime"].doubleValue
		msgType = json["msgType"].intValue
		msg = Msg(json["msg"])
		username = json["username"].stringValue
		imgUrl = json["imgUrl"].stringValue
		isPin = json["isPin"].intValue
		isMute = json["isMute"].intValue
		senderPbKey = json["senderPbKey"].stringValue
		enKey = json["enKey"].stringValue
		state = json["state"].intValue
		unreadCount = json["unreadCount"].intValue
	}
    
    func getOtherUserID() -> String{
        let myID = UserDefaultsToStoreUserInfo.getuserID()
        var userID = ""
        if senderId == myID{
            userID = receiverId ?? ""
        }
        else{
            userID = senderId ?? ""
        }
        return userID
    }
    
    func getChatUserDict() -> [String:String]{
        var dict = [String:String]()
        let myID = UserDefaultsToStoreUserInfo.getuserID()
        var userID = ""
        if senderId == myID{
            userID = receiverId ?? ""
        }
        else{
            userID = senderId ?? ""
        }
        dict["id"] = userID
        dict["name"] = username
        dict["image"] = imgUrl
        return dict
    }

}
