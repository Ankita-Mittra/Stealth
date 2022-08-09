//
//  GeneralResponseModel.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 05, 2022
//
import Foundation
import SwiftyJSON

struct GeneralResponseModel {

	let success: Bool?
	let code: Int?
	let message: String?
	let version: Int?

	init(_ json: JSON) {
		success = json["success"].boolValue
		code = json["code"].intValue
		message = json["message"].stringValue
		version = json["version"].intValue
	}

}
