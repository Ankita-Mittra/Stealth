//
//  SignUpResponse.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//


import Foundation
import Alamofire
import UIKit
// MARK: - SignUpResponse Model
//
//struct SignUpResponse: Codable {
//    let success: Bool
//    let code: Int
//    let message: String
//    let version: Int
//    let data: SignUpDataClass
//}
//
//// MARK: - DataClass
//struct SignUpDataClass: Codable {
//    let userId, token : String
//}
//
//

struct SignUpResponse: Codable {
    let userId: String
    let token: String

//    init(userId: String, token: String){
//
//    }
    
    init(with data: [String: AnyObject]?) {
        
        self.userId = data?[enumAPIKeysForUser.id_key.rawValue] as? String ?? emptyStr
        self.token = data?[enumAPICommonKeys.token_key.rawValue] as? String ?? emptyStr
    }

    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(String.self, forKey: .userId) ?? emptyStr
        token = try values.decodeIfPresent(String.self, forKey: .token) ?? emptyStr
    }


}


