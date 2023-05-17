//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on August 05, 2022
//

import Foundation
import SwiftyJSON

struct UploadFileResponseModel {

	let id: String?
	let path: String?
	let thumbUrl: String?
	let name: String?

	init(_ json: JSON) {
		id = json["id"].stringValue
		path = json["path"].stringValue
		thumbUrl = json["thumbUrl"].stringValue
		name = json["name"].stringValue
	}

}
