//
//  CreateGroupViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/06/2022.
//

import Foundation
import UIKit

class CreateGroupViewModel {
    
    // MARK: - Properties

    private var createGroupSuccess : Bool? {

        didSet {
            guard let c = createGroupSuccess else {return}
            self.createGroupResult = c
            self.didFinishFetch?()
        }
    }
    
    private var mediaId : String? {

        didSet {
            guard let m = mediaId else {return}
            self.bindDataWithVC(mediaID: m)
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
    var mediaID : String?
    var groupId : String?

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
              
                if let data =  tempData["data"] as? [String : AnyObject]{

                    if let groupId = data["id"] as?  String{
                        print("groupId...", groupId)
                        self.groupId = groupId
                    }
                }
                
                self.createGroupSuccess = succeeded
//                self.contact = UserModel(from: tempData) //SignUpResponse(with: tempData["data"] as? [String : AnyObject])
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
    
    func uploadFile(groupImage: UIImage) {
        self.updateLoadingStatus?()
        self.apiService?.uploadGroupImage(image: groupImage, imageName: "groupImage", completion: { data, succeeded, error in
            print("uploadFile   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData["id"] as? String)
               
                self.mediaId = tempData["id"] as? String
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
    
    
    // MARK: - UI Logic
    private func bindDataWithVC(mediaID: String) {
        print("bindDataWithVC", mediaID)
        
        self.mediaID = mediaID
    }
    
    
}
