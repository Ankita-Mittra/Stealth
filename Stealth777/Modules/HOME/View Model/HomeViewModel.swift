//
//  HomeViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
class HomeViewModel{
    
    //MARK: - Properties
   
    var sessionData:SessionListData?{
        didSet{
          didFinishSessionFeth?()
        }
    }
    private var apiService = ContactsAPIServices()
    private var chatAPIService = ChatAPIServices()
    private var groupAPIService = GroupsAPIServices()
    
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: ((String) -> ())?
    var didFinishSessionFeth: (() -> ())?
    var didFinishPin: ((String) -> ())?
    var didFinishMute: ((String) -> ())?
    var didFinishDelete: ((String) -> ())?
    
    
    
    // MARK: - Network call
    
    
    func fetchContacts() {
        CommonFxns.showProgress()
        apiService.getAllContacts { contacts in
            print("API Working::\(contacts.count)")
            self.saveContactsLocally(contactsArray: contacts)
            
        } failed: { error in
            self.showAlertClosure?(error)
        }

    }
    
    
    func fetchSessionList(){
        CommonFxns.showProgress()
        self.chatAPIService.getsessionLists { response in
            self.sessionData = response
            CommonFxns.dismissProgress()
        } failed: { error in
            self.showAlertClosure?(error)
        }

        
    }
    
    
    func fetchAllGroups() {
        self.groupAPIService.getAllGroupsList(completion: { modelArray in
            if modelArray.count > 0{
                print("Model Count:\(modelArray.count)")
                self.saveGroupsLocally(groupArray: modelArray)
            }
        }, failed: { error in
            self.showAlertClosure?(error)
            
        })

    }
    
    func pinUser(param:[String:Any]){
        CommonFxns.showProgress()
        chatAPIService.pinChat(parameters: param) { response in
            self.didFinishPin?(response.message ?? "")
        } failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        }

    }

    func muteUser(param:[String:Any]){
        CommonFxns.showProgress()
        chatAPIService.muteChat(parameters: param) { response in
            self.didFinishMute?(response.message ?? "")
        } failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        }

    }
    
    func deleteChat(chatID:String){
        CommonFxns.showProgress()
        chatAPIService.deleteChat(chatID: chatID) { response in
            self.didFinishDelete?(response.message ?? "")
        } failed: { error in
            self.showAlertClosure?(error)
        }

    }
    
    //MARK: - Local DB Operations
    
    
    // save groups to local db
    func saveGroupsLocally(groupArray:[GroupsModel]){
        GroupDatabaseQueries.addAndUpdateGroupsToLocalDB(groups: groupArray)

    }
    
    //Save contacts locally
    func saveContactsLocally(contactsArray:[UserModel]){
        ContactsDatabaseQueries.addAndUpdateContactsInLocalDB(contacts : contactsArray)
    }
    
}
