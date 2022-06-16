//
//  OtherUserProfileViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 06/06/2022.
//

import Foundation


class OtherUserProfileViewModel{
    
    private var respondRequestSuccess : Bool? {
        
        didSet {
            guard let r = respondRequestSuccess else {return}
            self.respondRequestResult = r
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var respondRequestResult: Bool?
        
    private var contactsApiService: ContactsAPIServices?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
        
    init(contactApiService: ContactsAPIServices) {
        self.contactsApiService = contactApiService
    }
    
    // MARK: - Network call

    func unfriendUser(selectedUser: String) {

        self.contactsApiService?.unfriendUser(userId: selectedUser, status: zero, completion: { data, succeeded, error in
            print("unfriendUser.....")
                if succeeded {
                    print("succeeded....", succeeded)
                    
                    self.respondRequestSuccess = succeeded
                    guard let tempData = data else{
                        self.error = error as? Error
                        return
                    }
                    print("tempData....", tempData)
                } else {
                self.error = error as? Error
                print("error....", error)
            }
        })
    }

}
