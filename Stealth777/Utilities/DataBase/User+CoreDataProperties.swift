//
//  User+CoreDataProperties.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/04/2022.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var accStatus: Int16
    @NSManaged public var allowWipeout: Bool
    @NSManaged public var bio: String?
    @NSManaged public var id: Int64
    @NSManaged public var imgUrl: String?
    @NSManaged public var isBlock: Bool
    @NSManaged public var isMute: Bool
    @NSManaged public var isPin: Bool
    @NSManaged public var lastOnlineTime: Date?
    @NSManaged public var onlineStatus: Int16
    @NSManaged public var pbKey: String?
    @NSManaged public var username: String?
    @NSManaged public var userType: Int16
    @NSManaged public var userRelation: UserRelation?

}

extension User : Identifiable {

}
