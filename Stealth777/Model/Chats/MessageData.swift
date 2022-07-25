//
//  MessageData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 25, 2022
//
import Foundation
import SwiftyJSON

struct MessageData {

	let page: Int?
	let count: Int?
	let lastPage: Int?
	let chatId: String?
	let messages: [MessageModel]?

	init(_ json: JSON) {
		page = json["page"].intValue
		count = json["count"].intValue
		lastPage = json["lastPage"].intValue
		chatId = json["chatId"].stringValue
		messages = json["messages"].arrayValue.map { MessageModel($0) }
	}

}
