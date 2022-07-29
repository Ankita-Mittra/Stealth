//
//  MessageContent.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on July 25, 2022
//
import Foundation
import SwiftyJSON

struct MessageContent {

	let text: String?

	init(_ json: JSON) {
		text = json["text"].stringValue
	}
<<<<<<< HEAD
    
    init(text:String?){
        self.text = text
    }
=======
>>>>>>> 67f5118 (Added make admin,session list and private chat listing apis)

}
