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
        case username = "name"
        case password = "password"
        case walletPhrase = "walletPhrase"
        case walletId = "walletKey"
        case deviceNo = "deviceNo"
        case deviceVersion = "deviceVersion"
        case deviceName = "deviceName"
        case platform = "platform"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        walletPhrase = try values.decodeIfPresent(String.self, forKey: .walletPhrase)
        walletId = try values.decodeIfPresent(String.self, forKey: .walletId)
        deviceNo = try values.decodeIfPresent(String.self, forKey: .deviceNo)
        deviceVersion = try values.decodeIfPresent(String.self, forKey: .deviceVersion)
        deviceName = try values.decodeIfPresent(String.self, forKey: .deviceName)
        platform = try values.decodeIfPresent(String.self, forKey: .platform)
    }
    
    func toAnyObject() -> Any {
        return [
            "name": username,
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
