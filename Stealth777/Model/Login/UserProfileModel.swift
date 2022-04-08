//
//  UserProfileModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcome: Codable {
//    let success: Bool
//    let code: Int
//    let message: String
//    let version: Int
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let user: User
//}
//
//// MARK: - User
//struct User: Codable {
//    let id, name, imageURL, wpharse: String
//    let wkey, bio: String       
//    let usertype, onlineStatus: Int
//    let lastOnlineTime: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case imageURL = "imageUrl"
//        case wpharse, wkey, bio, usertype, onlineStatus, lastOnlineTime
//    }
//}
