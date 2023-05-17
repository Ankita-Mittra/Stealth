//
//  Msg.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 25, 2022
//
import Foundation
import SwiftyJSON

struct Msg {

	let text: String?

	init(_ json: JSON) {
		text = json["text"].stringValue
	}

}