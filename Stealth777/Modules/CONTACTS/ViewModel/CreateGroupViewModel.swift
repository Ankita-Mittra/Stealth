//
//  CreateGroupViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/06/2022.
//

import Foundation

class CreateGroupViewModel {
    
    // MARK: - Properties

    private var createGroupSuccess : Bool? {

        didSet {
            guard let c = createGroupSuccess else {return}
            self.createGroupResult = c
            self.saveGroupInLocalDB()
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
    var createGroupResult : Bool?

    private var apiService: GroupsAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: GroupsAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func createGroup(parameters: [String: Any]) {
        self.updateLoadingStatus?()
        self.apiService?.createGroup(parameters: parameters, completion: { data, succeeded, error in
            print("createGroup   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                self.createGroupSuccess = succeeded
                
                
                //
                //            succeeded.... true
                //            tempData.... ["code": 200, "message": Group created successfully, "success": 1, "data": {
                //                id = "24e25c2d-bc89-492e-9f07-3e3fcd95ebd7";
                //            }, "version": 1]
                //
                //
                
                
                if let data =  tempData["data"] as? [String : AnyObject]{

                    if let groupId = data["id"] as?  String{
                        print("groupId...", groupId)
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
    private func saveGroupInLocalDB() {
        

        // save data locally
        print("Save group")
    }
    
    
}
