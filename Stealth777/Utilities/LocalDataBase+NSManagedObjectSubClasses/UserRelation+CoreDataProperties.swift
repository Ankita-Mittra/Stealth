//
//  UserRelation+CoreDataProperties.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/04/2022.
//
//

import Foundation
import CoreData


extension UserRelation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserRelation> {
        return NSFetchRequest<UserRelation>(entityName: "UserRelation")
    }

    @NSManaged public var receiverId: String?
    @NSManaged public var relation: Int16
    @NSManaged public var remarks: String?
    @NSManaged public var senderId: String?
    @NSManaged public var user: User?

}

extension UserRelation : Identifiable {

}
