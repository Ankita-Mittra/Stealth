//
//  APIService.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 29/03/2022.
//

import Foundation
import Alamofire

struct DataService {
    
    // MARK: - Singleton
    static let shared = DataService()
    
    // MARK: - URL
    private var baseUrl = "185.247.226.7./api/users/"
    
    enum enumAPIEndPoints: String {

        case login = "login"
        case register = "register"
        case profileInfo = "profile"
        case getContactsList = "getContactsList"
        case otherUserProfile = "queryUserById"
    }
    
}
