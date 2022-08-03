//
//  ChatAPIServices.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 14/07/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Services

class ChatAPIServices:WebService {
    
    func sendChatMessage(parameters: [String: Any],completion:@escaping (SendMessageModel) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.sendMessage.rawValue)"
        print("url....", url)
        post(url: url, params: parameters, completion: { json in
            let response = SendMessageModel(json!)
            completion(response)
            
        }, failed: failed)
        
    }
    
    func getMessagesByUserID(param:[String:Any],completion:@escaping (MessageData) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.getMessageByUserID.rawValue)"
        print("url....", url)
        get(url: url, params: param, completion: { json in
            let response = MessageData(json!)
            completion(response)
        }, failed: failed)
        
    }
    
    func getsessionLists(completion:@escaping (SessionListData) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.listSession.rawValue)"
        print("url....", url)
        get(url: url, params: [:], completion: { json in
            let response = SessionListData(json!)
            completion(response)
        }, failed: failed)
        
    }
    
}
    
    
    
    
    



