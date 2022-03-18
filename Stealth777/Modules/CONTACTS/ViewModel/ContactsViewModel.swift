//
//  ContactsViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/03/2022.
//

import Foundation

enum ContactsTableSection: Int {
    case requests
    case groups
    case contacts

    var sectionTitle: String {
        switch self {
        case .requests:
            return "Requests"
        case .groups:
            return "Group"
        case .contacts:
            return "Constacts"
        }
    }
}

class ContactsViewModel {


    
    func abc(){
        
    }
    
    
}
