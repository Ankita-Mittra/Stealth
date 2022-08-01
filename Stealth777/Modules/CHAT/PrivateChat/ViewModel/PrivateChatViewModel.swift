//
//  PrivateChatViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
import SwiftyJSON
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
    
    func getMessages(recieverID: String) {
        self.updateLoadingStatus?()
        let param = ["receiverId":recieverID]
        self.apiService?.getMessageByUserID(param: param, completion: { data, succeeded, error in
            print("getMessages   /.....")
            self.isLoading = false
            if succeeded{
                self.saveMessagesLocally(messages: data?.messages ?? [], recieverID: recieverID)
            }
            else{
                self.showAlertClosure?(error)
            }
            
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
                if let messageID = data?["msgId"] as? String{
                    guard let user = UserDefaultsToStoreUserInfo.getUser() else{return}
                    let msgDict = ["text":dict["msg"] as! String]
                    let dict:[String:Any] = ["msgId":messageID,
                                             "groupId":"",
                                             "senderName":user.username ?? "",
                                             "msg":msgDict,
                                             "quoteMsgId":"",
                                             "quoteMsg":"",
                                             "enKey":"",
                                             "senderPbKey":"",
                                             "state":"0",
                                             "senderId":user.userId ?? "",
                                             "receiverId":dict["receiverId"] as! String,
                                             "imgUrl":"",
                                             "msgType":1,
                                             "readTime":"",
                                             "sendTime":CommonFxns.getMilliseconds(date: Date())]
                   let msgObject  = MessageModel(JSON(dict))
                    self.saveMessagesLocally(messages: [msgObject], recieverID: dict["receiverId"] as! String)
                    
                }
            }
            else{
                self.showAlertClosure?(error)
            }
        })
    }
    
    //Fetch messages from local DB
    
    func getLocalMessages(id:String){
        messageList =  ChatsDatabaseQueries.fetchMessages(userID:id )
    }
    
    func saveMessagesLocally(messages:[MessageModel],recieverID:String){
        ChatsDatabaseQueries.saveMessages(messageList: messages)
        getLocalMessages(id: recieverID)
    }
        
    // MARK: - UI Logic
    private func bindDataToUI(with messages: [UserModel]) {
        
        
        
       // print("bindDataToUI....", self.messages)
    }
    
    
}
