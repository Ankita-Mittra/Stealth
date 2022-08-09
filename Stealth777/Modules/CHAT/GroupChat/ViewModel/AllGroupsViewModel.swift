//
//  AllGroupsViewModel.swift
//  Stealth777
//
//  Created by meem on 30/04/2022.
//

import Foundation

class AllGroupsViewModel {
    
    // MARK: - Properties

     var groups : [GroupsModel]? {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    private var apiService: GroupsAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: GroupsAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func fetchAllGroups() {
        CommonFxns.showProgress()
        self.apiService?.getAllGroupsList(completion: { modelArray in
            if modelArray.count > 0{
                self.saveGroupsLocally(groupArray: modelArray)
            }
        }, failed: { error in
            self.showAlertClosure?(error)
            
        })

    }
        
    //MARK: - Local DB Operations
    
    // feching groups from local db
    func getLocalGroups(){
        self.groups?.removeAll()
        self.groups = GroupDatabaseQueries.fetchGroups()
        
    }
    // save groups to local db
    func saveGroupsLocally(groupArray:[GroupsModel]){
        GroupDatabaseQueries.addAndUpdateGroupsToLocalDB(groups: groupArray)
        getLocalGroups()
    }
    
    
}
