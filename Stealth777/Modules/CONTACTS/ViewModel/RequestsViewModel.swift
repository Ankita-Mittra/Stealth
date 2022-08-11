//
//  RequestsViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 03/06/2022.
//

import Foundation


class RequestsViewModel {
    
    // MARK: - Properties

     var friendRequests : [UserModel]? {
        didSet {
            self.didFinishFetchContactRequests?()
        }
    }
    
     var groupInvitaions : [GroupInvitaionsListModel]? {
        didSet {
            self.didFinishFetchGroupInvitaions?()
        }
    }
    
    private var contactsApiService: ContactsAPIServices?
    private var groupApiService: GroupsAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetchContactRequests: (() -> ())?
    var didFinishFetchGroupInvitaions: (() -> ())?
    var didFinishRespondFriendRequest: ((String) -> ())?
    var didFinishRespondGroupRequest: ((String) -> ())?
    
    // MARK: - Constructor
    
    init(contactApiService: ContactsAPIServices, groupApiService: GroupsAPIServices) {
        self.contactsApiService = contactApiService
        self.groupApiService = groupApiService
    }
    
    // MARK: - Network call
    
    func getContactRequests() {
        CommonFxns.showProgress()
        contactsApiService?.getAllContactRequests(completion: { requests in
            self.friendRequests = requests
            
        }, failed: { error in
            self.showAlertClosure?(error)
        })

    }
    
    func getGroupInvitaions() {
        CommonFxns.showProgress()
        groupApiService?.getAllGroupInvitations(completion: { invitations in
            self.groupInvitaions = invitations
            
        }, failed: { error in
            self.showAlertClosure?(error)
        })
        
    }
        
    func respondFriendRequest(selectedUser: String, action: Int) {
        CommonFxns.showProgress()
        self.contactsApiService?.respondFriendRequest(userId: selectedUser, action: action, completion: { response in
            if action == one{
                self.saveUserAfterAccept(userID: selectedUser)
            }
            self.didFinishRespondFriendRequest?(response.message ?? "")
        }, failed: { error in
            self.showAlertClosure?(error)
        })


    }
        
func respondGroupRequest(groupId: String, status: Int) {
    CommonFxns.showProgress()
    self.groupApiService?.respondGroupRequest(groupId: groupId, status: status, completion: { response in
        self.didFinishRespondGroupRequest?(response.message ?? "")
    }, failed: { error in
        self.showAlertClosure?(error)
    })
    

}
    
    //MARK: - Local DB Operations
    
    func saveUserAfterAccept(userID:String){
        if let user = friendRequests?.filter({$0.userId == userID}).first{
            ContactsDatabaseQueries.addAndUpdateContactsInLocalDB(contacts: [user])
        
        }
        
    }
    
   
}

