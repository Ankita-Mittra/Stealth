//
//  APIService.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 29/03/2022.
//

import Foundation
import Alamofire

struct APIService {
    
//    // MARK: - Singleton
////    static let shared = APIService()
//    
//    // MARK: - URL
//    
    enum enumAPIEndPoints: String {

        case login = "login"
        case register = "register"
        case profileInfo = "profile"
        case getContactsList = "getContactsList"
        case otherUserProfile = "queryUserById"
    }
    
}
