//
//  ChatsDatabaseQueries.swift
//  Stealth777
//
//  Created by Manpreet Singh on 26/07/2022.
//

import Foundation
import UIKit
import CoreData

class ChatsDatabaseQueries{
    
    class func fetchMessages(userID:String) -> [MessageModel]{
        
        let context = appDelegate.persistentContainer.viewContext
        print("fetch messages...")
        var messageList = [MessageModel]()
        let myID = UserDefaultsToStoreUserInfo.getuserID()
        let fetchRequest: NSFetchRequest<Messages> = Messages.fetchRequest()
        let p1 = NSPredicate(format: "senderId = %@ AND receiverId = %@", myID, userID)
        let p2 = NSPredicate(format: "senderId = %@ AND receiverId = %@", userID, myID)
        fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [p1,p2])
        
        do {
            // Peform Fetch Request
            let messages = try context.fetch(fetchRequest)
            
            for msg in messages{
                let obj = MessageModel(message: msg)
                messageList.append(obj)
            }
            print("messages...", messages)
            
        } catch {
            print("Unable to Fetch Workouts, (\(error))")
        }
        return messageList
    }
    
    class func fetchGroupMessages(groupID:String) -> [MessageModel]{
        
        let context = appDelegate.persistentContainer.viewContext
        print("fetch messages...")
        var messageList = [MessageModel]()
        let fetchRequest: NSFetchRequest<Messages> = Messages.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "groupId == %@", groupID)
        
        do {
            // Peform Fetch Request
            let messages = try context.fetch(fetchRequest)
            
            for msg in messages{
                let obj = MessageModel(message: msg)
                messageList.append(obj)
            }
            print("messages...", messages)
            
        } catch {
            print("Unable to Fetch Workouts, (\(error))")
        }
        return messageList
    }

    class func isMessageExist(id: String) -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Messages")
        fetchRequest.predicate = NSPredicate(format: "msgId == %@", id)
        let res = try! context.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    class func saveMessages(messageList:[MessageModel]){
        let context = appDelegate.persistentContainer.viewContext
        
        for msg in messageList{
            do{
                let request: NSFetchRequest<Messages> = Messages.fetchRequest()
                request.predicate = NSPredicate(format: "msgId == %@", msg.msgId!) // Find Message
                
                let localmessages = try context.fetch(request)
                
                if let message = localmessages.first {
                    message.enKey = msg.enKey
                    message.groupId = msg.groupId
                    message.msg = msg.msg?.json.rawString() ?? ""
                    message.msgId = msg.msgId
                    message.msgType = Int16(msg.msgType!)
                    // message.qouteType = msg.
                    message.quoteMsg = msg.quoteMsg?.json.rawString() ?? ""
                    message.quoteMsgId = msg.quoteMsgId
                    message.readTime = msg.readTime ?? 0
                    message.receiverId = msg.receiverId
                    message.senderId = msg.senderId
                    message.senderImgUrl = msg.imgUrl
                    message.senderName = msg.senderName
                    message.senderPbKey = msg.senderPbKey
                    message.sendTime = msg.sendTime ?? 0
                    message.state = Int16(msg.state!)
                }
                else{
                    let message = Messages(context: context)
                    message.enKey = msg.enKey
                    message.groupId = msg.groupId
                    message.msg = msg.msg?.json.rawString() ?? ""
                    message.msgId = msg.msgId
                    message.msgType = Int16(msg.msgType!)
                    // message.qouteType = msg.
                    message.quoteMsg = msg.quoteMsg?.json.rawString() ?? ""
                    message.quoteMsgId = msg.quoteMsgId
                    message.readTime = msg.readTime ?? 0
                    message.receiverId = msg.receiverId
                    message.senderId = msg.senderId
                    message.senderImgUrl = msg.imgUrl
                    message.senderName = msg.senderName
                    message.senderPbKey = msg.senderPbKey
                    message.sendTime = msg.sendTime ?? 0
                    message.state = Int16(msg.state!)
                }
                try context.save()
            }
            catch {
                print("Failed to save message", error)
            }
            
            
        } // end for loop
        
        
        
    }
    
}




