//
//  OtherUserProfileViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 06/06/2022.
//

import Foundation


class OtherUserProfileViewModel{
    
        
     var contactsApiService = ContactsAPIServices()
    var chatApiService = ChatAPIServices()
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var didFinishUnfriend: ((String) -> ())?
    var didFinishBlock: ((String) -> ())?
    var didFinishPin: ((String) -> ())?
    var didFinishMute: ((String) -> ())?
    
    
    // MARK: - Network call

    func unfriendUser(userID: String) {
        CommonFxns.showProgress()
        self.contactsApiService.unfriendUser(userId: userID, status: one) { response in
            self.didFinishUnfriend?(response.message ?? "")
        } failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        }
    }
    
    func blockUser(userID:String){
        CommonFxns.showProgress()
        chatApiService.blockUser(userID: userID) { response in
            self.didFinishBlock?(response.message ?? "")
        } failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        }

        
    }

    func pinUser(param:[String:Any]){
        CommonFxns.showProgress()
        chatApiService.pinChat(parameters: param) { response in
            self.didFinishPin?(response.message ?? "")
        } failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        }

    }

    func muteUser(param:[String:Any]){
        CommonFxns.showProgress()
        chatApiService.muteChat(parameters: param) { response in
            self.didFinishMute?(response.message ?? "")
        } failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        }

    }

        

}
