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
    
    
    
    // MARK: - Network call
    
    
    func fetchContacts() {
        
        self.apiService.getContacts(completion: { data, succeeded, error in
            print("getContacts   /.....")
            
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.showAlertClosure?(AlertMessages.CAST_ERROR)
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
                        self.saveContactsLocally(contactsArray: contacts)
                        
                    }
                }
            } else {
                self.showAlertClosure?(error)
                print("error....", error)
            }
            
        })
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
