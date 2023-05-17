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
    @NSManaged public var allowWipeout: Int16
    @NSManaged public var bio: String?
    @NSManaged public var id: String
    @NSManaged public var imgUrl: String?
    @NSManaged public var thumbUrl: String?
    @NSManaged public var isBlock: Int16
    @NSManaged public var isMute: Int16
    @NSManaged public var isPin: Int16
    @NSManaged public var lastOnlineTime: Date?
    @NSManaged public var onlineStatus: Int16
    @NSManaged public var pbKey: String?
    @NSManaged public var username: String?
    @NSManaged public var userType: Int16
    @NSManaged public var userRelation: UserRelation?
    @NSManaged public var wKey: String?
}

extension User : Identifiable {


}
