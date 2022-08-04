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
          didFinishSessionFeth?()
        }
    }
    private var apiService = ContactsAPIServices()
    private var chatAPIService = ChatAPIServices()
    private var groupAPIService = GroupsAPIServices()
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?

    //MARK: - Closures for sessionList API
    var showSessionListError: ((String) -> ())?
    var didFinishSessionFeth: (() -> ())?
    
    //MARK: - Closures for groups API
    var showGroupsListError: ((String) -> ())?
    var didFinishGroupsFetch: (() -> ())?
    
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
        CommonFxns.showProgress()
        self.chatAPIService.getsessionLists { response in
            self.sessionData = response
        } failed: { error in
            self.showSessionListError?(error)
        }

        
    }
    
}
