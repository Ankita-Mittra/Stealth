//
//  LoginModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//

import Foundation
import Alamofire
import Foundation

// MARK: - Welcome
struct LoginModel: Codable {
    let success: Bool
    let code: Int
    let message: String
    let version: Int
    let data: LoginDataClass
}

// MARK: - DataClass
struct LoginDataClass: Codable {
    let id, token, accountStatus: String
}
