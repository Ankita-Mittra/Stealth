//
//  GroupChatViewModel.swift
//  Stealth777
//
//  Created by Manpreet Singh on 03/08/2022.
//

import Foundation

class GroupChatViewModel {
    
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
    
    // MARK: - Constructor
    
    init() {
        
    }
    
    // MARK: - Network call
    
    func getMessages(groupID: String) {
        
        CommonFxns.showProgress()
        let requestObj = ListMessageRequest(groupId: groupID, receiverId: nil, limit: 50)
        let param = requestObj.toDictionary()
        self.apiService.getMessagesByUserID(param: param, completion: { response in
            self.saveMessagesLocally(messages: response.messages ?? [], groupID: groupID)
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
            let messageObject = MessageModel(msgId: messageID, groupId: dict["groupId"] as! String, senderName: user.username ?? "", msgDict: msgDict, quoteMsgId: "", quoteMsgDict: [:], enKey: dict["enKey"] as! String, senderPbKey: dict["senderPbKey"] as! String, state: 0, senderId: user.userId ?? "", receiverId: "", imgUrl: "", msgType: 1, readTime: 0, sendTime: CommonFxns.getMilliseconds(date: Date()))
            self.saveMessagesLocally(messages: [messageObject], groupID: dict["groupId"] as! String)
            self.didFinishSendMessage?()
            
        }, failed: { errorMessage in
            self.showAlertClosure?(errorMessage)
        })
    }
        
        
    
    //Fetch messages from local DB
    
    func getLocalGroupMessages(id:String){
        messageList =  ChatsDatabaseQueries.fetchGroupMessages(groupID: id)
    }
    
    func saveMessagesLocally(messages:[MessageModel],groupID:String){
        ChatsDatabaseQueries.saveMessages(messageList: messages)
        getLocalGroupMessages(id: groupID)
    }
        
    
    
}
