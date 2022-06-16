//
//  RequestsViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 03/06/2022.
//

import Foundation


class RequestsViewModel {
    
    // MARK: - Properties

    private var friendRequests : [UserModel]? {
        
        didSet {
            guard let f = friendRequests else {return}
            self.bindFriendRequestsDataToUI(with: f)
            self.didFinishFetch?()
        }
    }
    
    private var groupInvitaions : [GroupInvitaionsListModel]? {
        
        didSet {
            guard let g = groupInvitaions else {return}
            self.bindGroupInvitesDataToUI(with: g)
            self.didFinishFetch?()
        }
    }
    
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
    
    var friendRequestsList: [UserModel]?
    var groupInvitaionsList: [GroupInvitaionsListModel]?
    var respondRequestResult : Bool?

    private var contactsApiService: ContactsAPIServices?
    private var groupApiService: GroupsAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(contactApiService: ContactsAPIServices, groupApiService: GroupsAPIServices) {
        self.contactsApiService = contactApiService
        self.groupApiService = groupApiService
    }
    
    // MARK: - Network call
    
    func getContactRequests() {
        self.contactsApiService?.getContactsRequests(completion: { data, succeeded, error in
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                var requests = [UserModel]()
                if let data =  tempData["data"] as? [String : AnyObject]{

                    if let users = data["user"] as?  [[String: Any]]{
                        print("users...", users)
                        for user in users{
                            let dict = UserModel(with: user)
                            
                            requests.append(dict)
                            print("dict...", dict)
                        }
                        self.friendRequests = requests
                    }
                }
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
    
    func getGroupInvitaions() {
        self.groupApiService?.getGroupInvitations(completion: { data, succeeded, error in

            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                var requests = [GroupInvitaionsListModel]()
                if let data =  tempData["data"] as? [String : AnyObject]{

                    if let groups = data["groupsInvitations"] as?  [[String: Any]]{
                        print("groupsInvitations...", groups)
                        for group in groups{
                            let dict = GroupInvitaionsListModel(with: group)
                            
                            requests.append(dict)
                            print("dict...", dict)
                        }
                        self.groupInvitaions = requests
                    }
                }
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
        
    func respondFriendRequest(selectedUser: String, action: Int) {

        self.contactsApiService?.respondFriendRequest(userId: selectedUser, action: action, completion: { data, succeeded, error in
            print("respondRequest   /.....")
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
        
func respondGroupRequest(groupId: String, status: Int) {

    self.groupApiService?.respondGroupRequest(groupId: groupId, status: status, completion: { data, succeeded, error in
        print("respondGroupRequest   /.....")
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
    
    // MARK: - UI Logic
    
    private func bindFriendRequestsDataToUI(with friendRequests: [UserModel]) {
        
        self.friendRequestsList = friendRequests
        
        print("bindFriendRequestsDataToUI....", self.friendRequestsList)
    }
    
    private func bindGroupInvitesDataToUI(with groupInvitaions: [GroupInvitaionsListModel]) {
        
        self.groupInvitaionsList = groupInvitaions
        
        print("bindGroupInvitesDataToUI....", self.groupInvitaionsList)
    }
    
}

