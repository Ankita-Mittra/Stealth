//
//  Groups+CoreDataProperties.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/04/2022.
//
//

import Foundation
import CoreData


extension Groups {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Groups> {
        return NSFetchRequest<Groups>(entityName: "Groups")
    }

    @NSManaged public var anonymous: Bool
    @NSManaged public var desc: String?
    @NSManaged public var disperse: Bool
    @NSManaged public var disperseDate: Date?
    @NSManaged public var imgUrl: String?
    @NSManaged public var thumbUrl: String?
    @NSManaged public var id: String?
    @NSManaged public var isMute: Bool
    @NSManaged public var isPin: Bool
    @NSManaged public var name: String?
    @NSManaged public var sendMessage: Bool
    @NSManaged public var showQR: Bool
    @NSManaged public var status: Int16
    @NSManaged public var groupMembers: GroupMembers?

}

extension Groups : Identifiable {

}
