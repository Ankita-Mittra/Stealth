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

    private var sendMessageSuccess : Bool? {

        didSet {
            guard let s = sendMessageSuccess else {return}
            self.sendMessageResult = s
            self.didFinishFetch?()
        }
    }
    
    private var messages : [UserModel]? {
        
        didSet {
            guard let m = messages else {return}
            self.bindDataToUI(with: m)
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = true {
        didSet { self.updateLoadingStatus?() }
    }
    
    var messagesList: [UserModel]?
    var sendMessageResult : Bool?
    private var apiService: ChatAPIServices?

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: ChatAPIServices) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func getMessages(userID: String) {
        self.updateLoadingStatus?()
        self.apiService?.getMessageByUserID(receiverID: userID, completion: { data, succeeded, error in
            print("getMessages   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
               
                var messages = [UserModel]()
                if let data =  tempData["data"] as? [String : AnyObject]{

                    if let allMessages = data["message"] as?  [[String: Any]]{
                        print("messages...", messages)
                        for user in allMessages{
                            let dict = UserModel(with: user)
                            
                            messages.append(dict)
                            
                            print("dict...", dict)
                        }
                        self.messagesList = messages
                    }
                }
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
    
    // Server call to send message
    func sendMessage(dict: [String: Any]) {
        self.updateLoadingStatus?()
        self.apiService?.sendMessage(parameters: dict, completion: { data, succeeded, error in
            print("sendMessage   /.....")
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)

                self.sendMessageSuccess = succeeded
            } else {
                self.error = error as? Error
                self.isLoading = false
                print("error....", error)
            }
        })
    }
        
    // MARK: - UI Logic
    private func bindDataToUI(with messages: [UserModel]) {
        
        self.messagesList = messages
        
        print("bindDataToUI....", self.messages)
    }
    
    
}
