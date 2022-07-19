//
//  SignUpRequest.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/04/2022.
//

import Foundation
import UIKit

struct SignUpRequest : Codable {
    let username : String?
    let password : String?
    let walletPhrase : String?
    let walletId : String?
    let deviceNo : String?
    let deviceVersion : String?
    let deviceName : String?
    let platform : String?
    
    
    enum CodingKeys: String, CodingKey {
        case username  = "name"
        case password = "password"
        case walletPhrase = "walletPhrase"
        case walletId = "walletKey"
        case deviceNo = "deviceNo"
        case deviceVersion = "deviceVersion"
        case deviceName = "deviceName"
        case platform = "platform"
    }
    
    func toAnyObject() -> Any {
        return [
            "name" : username,
            "password": password,
            "walletPhrase": walletPhrase,
            "deviceName": deviceName,
            "walletKey": walletId,
            "deviceNo": deviceNo,
            "deviceVersion": deviceVersion,
            "platform": platform
        ]
    }
}
