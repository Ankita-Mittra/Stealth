//
//  AllGroupsViewModel.swift
//  Stealth777
//
//  Created by meem on 30/04/2022.
//

import Foundation

class AllGroupsViewModel {
    
    // MARK: - Properties

    private var groups : [GroupsModel]? {
        
        didSet {
            guard let g = groups else {return}
            self.bindDataToUI(with: g)
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var groupList: [GroupsModel]?
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
    
    func fetchAllGroups() {
        
        self.updateLoadingStatus?()
        self.apiService?.getAllGroups(completion: { data, succeeded, error in
            print("getAllGroups /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                var groupList = [GroupsModel]()
                if let data =  tempData["data"] as? [String : AnyObject]{

                    if let groups = data["groups"] as?  [[String: Any]]{
                        print("groups...", groups)
                        for group in groups{
                            let dict = GroupsModel(with: group)
                            
                            groupList.append(dict)
                            print("dict...", dict)
                        }
                        self.groups = groupList
                    }
                }
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
        
    // MARK: - UI Logic
    private func bindDataToUI(with groups: [GroupsModel]) {
        
        self.groupList = groups
        
        print("bindDataToUI..groupList..", self.groupList)
    }
    
    
}
