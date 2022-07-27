//
//  SessionListData.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 25, 2022
//
import Foundation
import SwiftyJSON

struct SessionListData {

	let sessionList: [SessionList]?

	init(_ json: JSON) {
        sessionList = json["sessionList"].arrayValue.map { SessionList($0) }
	}

}
