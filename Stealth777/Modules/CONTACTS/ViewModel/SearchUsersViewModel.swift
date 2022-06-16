//
//  SearchUsersViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 30/05/2022.
//

import Foundation

class SearchUsersViewModel {

    // MARK: - Properties

    private var users : [UserModel]? {
        didSet {
            guard let u = users else {return}
            self.bindDataToUI(with: u)
            self.didFinishFetch?()
        }
    }

    private var sendRequestSuccess : Bool? {

        didSet {
            guard let s = sendRequestSuccess else {return}
            self.sendRequestResult = s
            self.didFinishFetch?()
        }
    }

    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
        
    var searchedUsers: [UserModel]?
    var sendRequestResult : Bool?

    private var apiService: UserAPIServices?
    private var contactApiService: ContactsAPIServices?
    

// MARK: - Closures for callback, since we are not using the ViewModel to the View.

var showAlertClosure: (() -> ())?
var updateLoadingStatus: (() -> ())?
var didFinishFetch: (() -> ())?

// MARK: - Constructor

init(apiService: UserAPIServices, contactApiService: ContactsAPIServices) {
    self.apiService = apiService
        
    self.contactApiService = contactApiService
}

// MARK: - Network call

    func fetchSearchedUsers(username:String) {

        self.apiService?.searchUser(username: username, completion: { data, succeeded, error in
            print("searchUser   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    return
                }
                print("tempData....", tempData)
                var searchedUser = [UserModel]()
                
                if let data =  tempData["data"] as? [String : AnyObject]{
                    if let user = data["user"] as? [String: Any]{
                        print("users...", user)
                        let dict = UserModel(with: user)
                        print("dict...", dict)
                        searchedUser.append(dict)
                    }
                    self.users = searchedUser
                }
            } else {
                self.error = error as? Error
               print("error....", error)
            }
        })
    }
    
    func sendRequest(selectedUser: String) {

        self.contactApiService?.sendRequest(userId: selectedUser, completion: { data, succeeded, error in
            print("send request    /.....")
                if succeeded {
                    print("succeeded....", succeeded)
                    
                    self.sendRequestSuccess = succeeded
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


// MARK: - UI Logic
    
private func bindDataToUI(with users: [UserModel]) {
    
    self.searchedUsers = users
    
    print("bindDataToUI....", self.searchedUsers)
}

//    private func sentRequestRepo(with users: [UserModel]) {
//
//        self.searchedUsers = users
//
//        print("bindDataToUI....", self.searchedUsers)
//
//    }


}

