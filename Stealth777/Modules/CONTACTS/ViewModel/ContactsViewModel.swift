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
            return "Contacts"
        }
    }
}

class ContactsViewModel {
    
    // MARK: - Properties

     var contacts : [UserModel]? {
        
        didSet {
            
            self.didFinishFetch?()
        }
    }
    
    
    private var apiService: ContactsAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: ContactsAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func fetchContacts() {
        CommonFxns.showProgress()
        apiService?.getAllContacts { contacts in
            print("API Working::\(contacts.count)")
            self.contacts = contacts
            
        } failed: { error in
            self.showAlertClosure?(error)
        }

    }
    
    
        
    
    
}
