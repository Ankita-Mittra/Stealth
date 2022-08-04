//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 03, 2022
//
import Foundation
import SwiftyJSON

struct SendMessageModel {

	let msgId: String?

	init(_ json: JSON) {
		msgId = json["msgId"].stringValue
	}

}
