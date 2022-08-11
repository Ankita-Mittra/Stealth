//
//  TokenInfo+CoreDataProperties.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/08/2022.
//
//

import Foundation
import CoreData


extension TokenInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TokenInfo> {
        return NSFetchRequest<TokenInfo>(entityName: "TokenInfo")
    }

    @NSManaged public var balance: String?
    @NSManaged public var contractAddress: String?
    @NSManaged public var decimals: String?
    @NSManaged public var name: String?
    @NSManaged public var network: String?
    @NSManaged public var symbol: String?

}

extension TokenInfo : Identifiable {

}
