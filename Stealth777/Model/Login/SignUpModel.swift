//
//  SignUpModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//

// MARK: - SignUpModel
struct SignUpModel: Codable {
    let success: Bool
    let code: Int
    let message: String
    let version: Int
    let data: SignUpDataClass
}

// MARK: - DataClass
struct SignUpDataClass: Codable {
    let id, token: String
}
