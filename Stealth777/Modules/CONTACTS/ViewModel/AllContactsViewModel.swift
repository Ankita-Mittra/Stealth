//
//  AllContactsViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 17/06/2022.
//

import Foundation

class AllContactsViewModel {
    
    // MARK: - Properties
    
    private var members : [GroupMembersModel]? {
        didSet {
            guard let m = members else {return}
            self.bindDataToUI(with: m)
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var groupMembers : [GroupMembersModel]?

    private var apiService: GroupsAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    var successAlert:((String)->Void)?
    var errorAlert:((String)->Void)?
    
    // MARK: - Constructor
    
    init(apiService: GroupsAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func getAllGroupMembers(groupId: String) {
        self.updateLoadingStatus?()
        
        self.apiService?.getAllGroupMembers(groupId: groupId, completion: { data, succeeded, error in
            print("getAllGroupMembers   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
                var members = [GroupMembersModel]()

                if let data =  tempData["data"] as? [String : AnyObject]{
                    if let users = data["users"] as? [[String: Any]]{
                        for user in users{
                            let dict = GroupMembersModel(with: user)
                            print("dict...", dict)
                            members.append(dict)
                        }
                        self.members = members
                    }
                }
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
    
    func addGroupMembers(memberIds: [String], groupId: String) {
        self.updateLoadingStatus?()
        
        self.apiService?.addMembersInGroup(memberIds: memberIds, groupId: groupId, completion: { data, succeeded, error in
            print("getContacts   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                self.didFinishFetch?()
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
    
    func removeGroupMember(userId: String, groupId: String) {
        self.updateLoadingStatus?()
        
        self.apiService?.removeMembersInGroup(userId: userId, groupId: groupId, completion: { data, succeeded, error in
            print("remove group member   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                self.didFinishFetch?()
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
    
    func callMakeAdmin(userID:String,groupID:String){
        self.updateLoadingStatus?()
        let param:[String:Any] = ["id":groupID,
                     "userId":userID,
                     "status":3]
        self.apiService?.setGroupAdmin(parameters: param, completion: { data, succeeded, error in
            self.isLoading = false
            if succeeded{
                self.successAlert?(error)
            }
            else{
                self.errorAlert?(error)
            }
        })
    }
        
    // MARK: - UI Logic
        
    private func bindDataToUI(with members: [GroupMembersModel]) {
        
        self.groupMembers = members
        
        print("bindDataToUI....", self.groupMembers)
    }
}
