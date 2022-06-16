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

    private var contacts : [UserModel]? {
        
        didSet {
            guard let c = contacts else {return}
            self.bindDataToUI(with: c)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var contactsList: [UserModel]?
    private var apiService: ContactsAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: ContactsAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func fetchContacts() {
        self.updateLoadingStatus?()
        self.apiService?.getContacts(completion: { data, succeeded, error in
            print("getContacts   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                var contacts = [UserModel]()
                if let data =  tempData["data"] as? [String : AnyObject]{

                    if let users = data["user"] as?  [[String: Any]]{
                        print("users...", users)
                        for user in users{
                            let dict = UserModel(with: user)
                            
                            contacts.append(dict)
                            print("dict...", dict)
                        }
                        self.contacts = contacts
                    }
                }
//                self.contact = UserModel(from: tempData) //SignUpResponse(with: tempData["data"] as? [String : AnyObject])
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
        
    // MARK: - UI Logic
    private func bindDataToUI(with contacts: [UserModel]) {
        
        self.contactsList = contacts
        
        print("bindDataToUI....", self.contacts)
    }
    
    
}
