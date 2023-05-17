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

    @NSManaged public var anonymous: Int16
    @NSManaged public var desc: String?
    @NSManaged public var disperse: Int16
    @NSManaged public var disperseDate: String?
    @NSManaged public var imgUrl: String?
    @NSManaged public var thumbUrl: String?
    @NSManaged public var id: String?
    @NSManaged public var isMute: Int16
    @NSManaged public var isPin: Int16
    @NSManaged public var name: String?
    @NSManaged public var sendMessage: Int16
    @NSManaged public var showQR: Int16
    @NSManaged public var status: Int16
    @NSManaged public var groupMembers: NSSet?
    @NSManaged public var groupRole:Int16

}

extension Groups : Identifiable {

}
