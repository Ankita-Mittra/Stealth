//
//  GroupDetailsViewModel.swift
//  Stealth777
//
//  Created by Manpreet Singh on 22/07/2022.
//

import Foundation

class GroupDetailsViewModel{
    
    //MARK: - Properties
    private var apiService = GroupsAPIServices()
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishAction: ((String) -> ())?
    
    //MARK: - APIs
    func callDeleteGroup(id:String){
        self.updateLoadingStatus?()
        apiService.deleteGroup(groupId: id) { data, succeeded, error in
            self.isLoading = false
            if succeeded{
                self.didFinishAction?(error)
            }
            else{
                self.showAlertClosure?(error)
            }
        }
        
        
    }
    
    func callExitGroup(id:String){
        self.updateLoadingStatus?()
        apiService.exitGroup(groupId: id) { data, succeeded, error in
            self.isLoading = false
            if succeeded{
                self.didFinishAction?(error)
            }
            else{
                self.showAlertClosure?(error)
            }
        }
        
        
    }
}
