//
//  Messages+CoreDataProperties.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/04/2022.
//
//

import Foundation
import CoreData


extension Messages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Messages> {
        return NSFetchRequest<Messages>(entityName: "Messages")
    }

    @NSManaged public var enKey: String?
    @NSManaged public var groupId: String?
    @NSManaged public var msg: Data?
    @NSManaged public var msgId: String?
    @NSManaged public var msgType: Int16
    @NSManaged public var qouteType: Int16
    @NSManaged public var quoteMsg: Data?
    @NSManaged public var quoteMsgId: String?
    @NSManaged public var readTime: Date?
    @NSManaged public var receiverId: String?
    @NSManaged public var senderId: String?
    @NSManaged public var senderImgUrl: String?
    @NSManaged public var senderName: String?
    @NSManaged public var senderPbKey: String?
    @NSManaged public var sendTime: Date?
    @NSManaged public var state: Int16

}

extension Messages : Identifiable {

}
