//
//  GroupMembers+CoreDataProperties.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/04/2022.
//
//

import Foundation
import CoreData


extension GroupMembers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupMembers> {
        return NSFetchRequest<GroupMembers>(entityName: "GroupMembers")
    }

    @NSManaged public var id: String?
    @NSManaged public var status: Int16
    @NSManaged public var userId: String?
    @NSManaged public var group: Groups?

}

extension GroupMembers : Identifiable {

}
