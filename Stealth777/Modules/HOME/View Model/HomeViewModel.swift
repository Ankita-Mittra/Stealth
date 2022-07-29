//
//  HomeViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
class HomeViewModel{
    
    //MARK: - Properties
    
    var contactsList: [UserModel]?{
        didSet{
            self.didFinishFetch?()
        }
    }
    
    var sessionData:SessionListData?{
        didSet{
<<<<<<< HEAD
          didFinishSessionFetch?()
        }
    }
    
    private var apiService = ContactsAPIServices()
    private var chatAPIService = ChatAPIServices()
    private var groupAPIService = GroupsAPIServices()
    
=======
          didFinishSessionFeth?()
        }
    }
    private var apiService = ContactsAPIServices()
    private var chatAPIService = ChatAPIServices()
>>>>>>> 67f5118 (Added make admin,session list and private chat listing apis)
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?

    //MARK: - Closures for sessionList API
    var showSessionListError: ((String) -> ())?
<<<<<<< HEAD
    var didFinishSessionFetch: (() -> ())?
=======
    var didFinishSessionFeth: (() -> ())?
>>>>>>> 67f5118 (Added make admin,session list and private chat listing apis)
    
    //MARK: - Closures for GroupList API
    var showGroupListError: ((String) -> ())?
    var didFinishGroupFetch: (() -> ())?
//    // MARK: - Constructor
//    
//    init(apiService: ContactsAPIServices) {
//        self.apiService = apiService
//    }
//    
    // MARK: - Network call
    
    
    func fetchContacts() {
        self.updateLoadingStatus?()
        self.apiService.getContacts(completion: { data, succeeded, error in
            print("getContacts   /.....")
            self.isLoading = false
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
                        self.contactsList = contacts
                        
                    }
                }
            } else {
                self.showAlertClosure?(error)
                print("error....", error)
            }
            
        })
    }
    
    
    func fetchSessionList(){
        self.updateLoadingStatus?()
        self.chatAPIService.getSessionList { data, succeeded, error in
            self.isLoading = false
            if succeeded{
                self.sessionData = data
            }
            else{
                self.showSessionListError?(error)
            }
        }
        
    }
    
<<<<<<< HEAD
    
    func fetchAllGroups() {
        
        self.updateLoadingStatus?()
        self.groupAPIService.getAllGroups(completion: { data, succeeded, error in
            print("getAllGroups /.....")
            if succeeded{
//                self.sessionData = data
            }
            else{
//                self.showSessionListError?(error)
            }
        })
    }
       
    
    
    
=======
>>>>>>> 67f5118 (Added make admin,session list and private chat listing apis)
}
