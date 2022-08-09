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
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = SendMessageModel(json!)
            completion(response)
            
        }, failed: failed)
        
    }
    
    func getMessagesByUserID(param:[String:Any],completion:@escaping (MessageData) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.getMessageByUserID.rawValue)"
        print("url....", url)
        get(url: url, params: param, completion: { json in
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = MessageData(json!)
            completion(response)
        }, failed: failed)
        
    }
    
    func getsessionLists(completion:@escaping (SessionListData) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.listSession.rawValue)"
        print("url....", url)
        get(url: url, params: [:], completion: { json in
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = SessionListData(json!)
            completion(response)
        }, failed: failed)
        
    }
    
    
    func sendMediaFile(file:UploadFile,completion:@escaping (UploadFileResponseModel) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.uploadFile.rawValue)"
        print("url....", url)
        uploadFilePost(url: url, params: [:], files: [file], completion: { json in
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = UploadFileResponseModel(json!)
            completion(response)
            
        }, failed: failed)
       
        
    }
    
    func pinChat(parameters: [String: Any],completion:@escaping (GeneralResponseModel) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.pinChat.rawValue)"
        print("url....", url)
        post(url: url, params: parameters, completion: { json in
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = GeneralResponseModel(json!)
            completion(response)
            
        }, failed: failed)
        
    }
    
    func muteChat(parameters: [String: Any],completion:@escaping (GeneralResponseModel) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.muteUser.rawValue)"
        print("url....", url)
        post(url: url, params: parameters, completion: { json in
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = GeneralResponseModel(json!)
            completion(response)
            
        }, failed: failed)
        
    }
    
    func blockUser(userID: String,completion:@escaping (GeneralResponseModel) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.blockUser.rawValue)"
        print("url....", url)
        let parameters = [userId_API_key:userID]
        post(url: url, params: parameters, completion: { json in
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = GeneralResponseModel(json!)
            completion(response)
            
        }, failed: failed)
        
    }
    
    func deleteMessage(parameters: [String: Any],completion:@escaping (SendMessageModel) -> Void, failed: @escaping (String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.deleteChats.rawValue)"
        print("url....", url)
        delete(url: url, params: parameters, completion: { json in
            if json == nil{
                failed(AlertMessages.CAST_ERROR)
                return
            }
            let response = SendMessageModel(json!)
            completion(response)
            
        }, failed: failed)
        
    }
}
    
    
    
    
    



