//
//  WalletTransactions+CoreDataProperties.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 09/08/2022.
//
//

import Foundation
import CoreData


extension WalletTransactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WalletTransactions> {
        return NSFetchRequest<WalletTransactions>(entityName: "WalletTransactions")
    }

    @NSManaged public var network: String?
    @NSManaged public var status: String?
    @NSManaged public var date: String?
    @NSManaged public var totalAmount: String?
    @NSManaged public var to: String?
    @NSManaged public var from: String?
    @NSManaged public var amount: String?
    @NSManaged public var gasFee: String?

}

extension WalletTransactions : Identifiable {

}
