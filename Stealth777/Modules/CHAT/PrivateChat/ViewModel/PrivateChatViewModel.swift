//
//  PrivateChatViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
//
//            {
//                "msg": "hi user7777",
//                "groupId": "",
//                "receiverId": "108ab439-395b-4429-9079-0b8b227480d0",
//                "senderPbKey" : "",
//                "mediaId" : "",
//                "enKey": "" ,
//                "quoteMsgId": "",
//                "msgType" : 1
//            }
            
class PrivateChatViewModel {
    
    // MARK: - Properties
    var messageList:[MessageModel]?{
        didSet{
            self.didFinishFetch?()
        }
    }
    
<<<<<<< HEAD
=======
    var messageData:MessageData?{
        didSet{
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
>>>>>>> 67f5118 (Added make admin,session list and private chat listing apis)
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    private var apiService: ChatAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: ChatAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func getMessages(userID: String) {
        self.updateLoadingStatus?()
        let param = ["receiverId":userID]
        self.apiService?.getMessageByUserID(param: param, completion: { data, succeeded, error in
            print("getMessages   /.....")
            self.isLoading = false
            if succeeded{
<<<<<<< HEAD
                self.messageList = data?.messages
            }
            else{
                self.showAlertClosure?(error)
            }
=======
                
            }
>>>>>>> 67f5118 (Added make admin,session list and private chat listing apis)
            
        })
    }
    
    // Server call to send message
    func sendMessage(dict: [String: Any]) {
       // self.isLoading = true
        self.updateLoadingStatus?()
        self.apiService?.sendMessage(parameters: dict, completion: { data, succeeded, error in
            print("sendMessage   /.....")
            self.isLoading = false
            if succeeded{
                
            }
            else{
                self.showAlertClosure?(error)
            }
        })
    }
        
    // MARK: - UI Logic
    private func bindDataToUI(with messages: [UserModel]) {
        
        
        
       // print("bindDataToUI....", self.messages)
    }
    
    
}
