//
//  PrivateChatViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
import SwiftyJSON

            
class PrivateChatViewModel {
    
    // MARK: - Properties
    var messageList:[MessageModel]?{
        didSet{
            self.didFinishFetch?()
        }
    }
    
    
    private var apiService = ChatAPIServices()

    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: ((String) -> ())?
    var didFinishFetch: (() -> ())?
    var didFinishSendMessage: (() -> ())?
    var didFinishUploadFile:((String)->())?
    
    // MARK: - Constructor
    
    init() {
       
    }
    
    // MARK: - Network call
    
    //server call to send messages
    func getMessages(recieverID: String) {
        CommonFxns.showProgress()
        let requestObj = ListMessageRequest(groupId: nil, receiverId: recieverID, limit: 50)
        let param = requestObj.toDictionary()
        self.apiService.getMessagesByUserID(param: param, completion: { response in
            self.saveMessagesLocally(messages: response.messages ?? [], recieverID: recieverID)
        }, failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        })
    }
        

    
    // Server call to send message
    func sendMessage(dict: [String: Any]) {
        CommonFxns.showProgress()
        self.apiService.sendChatMessage(parameters: dict, completion: { response in
            guard let messageID = response.msgId else{return}
            guard let user = UserDefaultsToStoreUserInfo.getUser() else{return}
            let msgDict = ["text":dict["msg"] as! String]
            let messageObject = MessageModel(msgId: messageID, groupId: "", senderName: user.username ?? "", msgDict: msgDict, quoteMsgId: "", quoteMsgDict: [:], enKey: dict["enKey"] as! String, senderPbKey: dict["senderPbKey"] as! String, state: 0, senderId: user.userId ?? "", receiverId: dict["receiverId"] as! String, imgUrl: "", msgType: 1, readTime: 0, sendTime: CommonFxns.getMilliseconds(date: Date()))
            self.saveMessagesLocally(messages: [messageObject], recieverID: dict["receiverId"] as! String)
            self.didFinishSendMessage?()
            
        }, failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        })
    }
    
    //server call to upload file
    func uploadFile(file:UploadFile){
        CommonFxns.showProgress()
        self.apiService.sendMediaFile(file: file) { response in
            if let mediaID = response.id{
            self.didFinishUploadFile?(mediaID)
            }
        } failed: { msg in
            self.showAlertClosure?(msg)
        }

    }
        
        
    
    //MARK: - Local DB Operations
    
    func getLocalMessages(id:String){
        messageList =  ChatsDatabaseQueries.fetchMessages(userID:id )
    }
    
    func saveMessagesLocally(messages:[MessageModel],recieverID:String){
        ChatsDatabaseQueries.saveMessages(messageList: messages)
        getLocalMessages(id: recieverID)
    }
   
    
}
