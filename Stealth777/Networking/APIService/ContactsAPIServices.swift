//
//  ContactsAPIServices.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 25/05/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreVideo

// MARK: - Services

struct ContactsAPIServices {

     func getContacts(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
    
        let url = baseUrl + "\(enumAPIEndPoints.getContactsList.rawValue)"
        print("url....", url)
        print("headers....", CommonFxns.getAuthenticationToken())
         
         
         let headers = CommonFxns.getAuthenticationToken()
         
         Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
            guard response.result.error == nil else {
                
                DispatchQueue.main.async(execute: {
                    
                    completion(nil, false, response.result.error.debugDescription)
                })
                return
            }
            print(response.result.description)
            
            if let value: AnyObject = response.result.value as AnyObject? {
                let json = JSON(value)
                
                print("value result....", value)

                var message = ""; var code = 0;
                if (value["message"] as AnyObject) as? String != nil {
                    message = ((value["message"]! as AnyObject) as? String)!
                    print("message...", message)
                }
                
                if (value["code"] as AnyObject) as? Int != nil {
                    code = ((value["code"]! as AnyObject) as? Int)!
                    print("code...", code)
                    
                    if code == 200{
                        DispatchQueue.main.async(execute: {
                            
                            completion(json.dictionaryObject as [String: AnyObject]?, true, message)
                        })
                    }else{
                        completion(json.dictionaryObject as [String: AnyObject]?, false, message)
                    }
                }else{
                    completion(nil, false, response.result.error.debugDescription)
                }

            } else {
                completion(nil, false, response.result.error.debugDescription)
            }
        }
    }
    
    func sendRequest(userId: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.sendRequest.rawValue)"
        print("url....", url)
        print("userId...", userId)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [userId_API_key : userId]

         Alamofire.request(url, method: .post, parameters: parmeters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
           guard response.result.error == nil else {
               
               DispatchQueue.main.async(execute: {
                   
                   completion(nil, false, response.result.error.debugDescription)
               })
               return
           }
             
           print(response.result.description)
           
           if let value: AnyObject = response.result.value as AnyObject? {
               let json = JSON(value)
               
               print("value result....", value)

               var message = ""; var code = 0;
               if (value["message"] as AnyObject) as? String != nil {
                   message = ((value["message"]! as AnyObject) as? String)!
                   print("message...", message)
               }
               
               if (value["code"] as AnyObject) as? Int != nil {
                   code = ((value["code"]! as AnyObject) as? Int)!
                   print("code...", code)
                   
                   if code == 200{
                       DispatchQueue.main.async(execute: {
                           
                           completion(json.dictionaryObject as [String: AnyObject]?, true, message)
                       })
                   }else{
                       completion(json.dictionaryObject as [String: AnyObject]?, false, message)
                   }
               }else{
                   completion(nil, false, response.result.error.debugDescription)
               }

           } else {
               completion(nil, false, response.result.error.debugDescription)
           }
       }
       
   }

    func respondFriendRequest(userId: String, action: Int,completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.respondRequest.rawValue)"
        print("url....", url)
        print("userId..action..", userId, action)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [userId_API_key : userId, action_API_key : action] as [String : Any]

         Alamofire.request(url, method: .post, parameters: parmeters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
           guard response.result.error == nil else {
               
               DispatchQueue.main.async(execute: {
                   
                   completion(nil, false, response.result.error.debugDescription)
               })
               return
           }
             
           print(response.result.description)
           
           if let value: AnyObject = response.result.value as AnyObject? {
               let json = JSON(value)
               
               print("value result....", value)

               var message = ""; var code = 0;
               if (value["message"] as AnyObject) as? String != nil {
                   message = ((value["message"]! as AnyObject) as? String)!
                   print("message...", message)
               }
               
               if (value["code"] as AnyObject) as? Int != nil {
                   code = ((value["code"]! as AnyObject) as? Int)!
                   print("code...", code)
                   
                   if code == 200{
                       DispatchQueue.main.async(execute: {
                           
                           completion(json.dictionaryObject as [String: AnyObject]?, true, message)
                       })
                   }else{
                       completion(json.dictionaryObject as [String: AnyObject]?, false, message)
                   }
               }else{
                   completion(nil, false, response.result.error.debugDescription)
               }

           } else {
               completion(nil, false, response.result.error.debugDescription)
           }
       }
       
   }
    
    
    
    func getContactsRequests(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.getContactRequests.rawValue)"
        print("url....", url)

        let headers = CommonFxns.getAuthenticationToken()

         Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
           guard response.result.error == nil else {
               DispatchQueue.main.async(execute: {
                   completion(nil, false, response.result.error.debugDescription)
               })
               return
           }
           print(response.result.description)
           
           if let value: AnyObject = response.result.value as AnyObject? {
               let json = JSON(value)
               
               print("value result....", value)
               var message = ""; var code = 0;
               if (value["message"] as AnyObject) as? String != nil {
                   message = ((value["message"]! as AnyObject) as? String)!
                   print("message...", message)
               }
               
               if (value["code"] as AnyObject) as? Int != nil {
                   code = ((value["code"]! as AnyObject) as? Int)!
                   print("code...", code)
                   
                   if code == 200{
                       DispatchQueue.main.async(execute: {
                           
                           completion(json.dictionaryObject as [String: AnyObject]?, true, message)
                       })
                   }else{
                       completion(json.dictionaryObject as [String: AnyObject]?, false, message)
                   }
               }else{
                   completion(nil, false, response.result.error.debugDescription)
               }

           } else {
               completion(nil, false, response.result.error.debugDescription)
           }
       }
   }
    
    func unfriendUser(userId: String, status: Int,completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.unfriendUser.rawValue)"
        print("url....", url)
        print("userId.. status...", userId, status)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [userId_API_key : userId, status_API_key : status] as [String : Any]

         Alamofire.request(url, method: .post, parameters: parmeters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
           guard response.result.error == nil else {
               
               DispatchQueue.main.async(execute: {
                   
                   completion(nil, false, response.result.error.debugDescription)
               })
               return
           }
             
           print(response.result.description)
           
           if let value: AnyObject = response.result.value as AnyObject? {
               let json = JSON(value)
               
               print("value result....", value)

               var message = ""; var code = 0;
               if (value["message"] as AnyObject) as? String != nil {
                   message = ((value["message"]! as AnyObject) as? String)!
                   print("message...", message)
               }
               
               if (value["code"] as AnyObject) as? Int != nil {
                   code = ((value["code"]! as AnyObject) as? Int)!
                   print("code...", code)
                   
                   if code == 200{
                       DispatchQueue.main.async(execute: {
                           
                           completion(json.dictionaryObject as [String: AnyObject]?, true, message)
                       })
                   }else{
                       completion(json.dictionaryObject as [String: AnyObject]?, false, message)
                   }
               }else{
                   completion(nil, false, response.result.error.debugDescription)
               }

           } else {
               completion(nil, false, response.result.error.debugDescription)
           }
       }
       
   }

    
}

//extension APIService{
//    var headers = [String:String]()
//
//    headers = [
//       "Authorization" : String(format: "Bearer: @%", userDefault.value(forKey: USER_DEFAULT_token_Key) as? String ?? emptyStr)
//    ]
//
//    return headers
//}
