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

struct ChatAPIServices {

     func sendMessage(parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
    
        let url = baseUrl + "\(enumAPIEndPoints.sendMessage.rawValue)"
        print("url....", url)
        let headers = CommonFxns.getAuthenticationToken()

        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
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
    
    func getMessageByUserID(param:[String:Any], completion: @escaping (_ data: MessageData?, _ succeeded: Bool, _ error: String) -> Void) {
   
       let url = baseUrl + "\(enumAPIEndPoints.getMessageByUserID.rawValue)"
       print("url....", url)
       let headers = CommonFxns.getAuthenticationToken()

       Alamofire.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: headers).responseJSON {response in
           guard response.result.error == nil else {
               
               DispatchQueue.main.async(execute: {
                   
                   completion(nil, false, response.result.error.debugDescription)
                   
               })
               
               return
           }
           print(response.result.description)
           if let value: AnyObject = response.result.value as AnyObject? {
               print("value result....", value)

               var message = ""; var code = 0;
               let data = value["data"] as AnyObject
               let json = JSON(data)
               if (value["message"] as AnyObject) as? String != nil {
                   message = ((value["message"]! as AnyObject) as? String)!
                   print("message...", message)
               }
               
               if (value["code"] as AnyObject) as? Int != nil {
                   code = ((value["code"]! as AnyObject) as? Int)!
                   print("code...", code)
                   
                   if code == 200{
                       DispatchQueue.main.async(execute: {
                           
                           let messageData = MessageData(json)
                           completion(messageData, true, message)
                       })
                   }else{
                       completion(nil, false, message)
                   }
               }else{
                   completion(nil, false, response.result.error.debugDescription)
               }

           } else {
               completion(nil, false, response.result.error.debugDescription)
           }
       }
           

           
          
       
   }
    
    
    func getSessionList(completion: @escaping (_ data: SessionListData?, _ succeeded: Bool, _ error: String) -> Void){
        let url = baseUrl + "\(enumAPIEndPoints.listSession.rawValue)"
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
                print("value result....", value)

                var message = ""; var code = 0;
                let data = value["data"] as AnyObject
                let json = JSON(data)
                if (value["message"] as AnyObject) as? String != nil {
                    message = ((value["message"]! as AnyObject) as? String)!
                    print("message...", message)
                }
                
                if (value["code"] as AnyObject) as? Int != nil {
                    code = ((value["code"]! as AnyObject) as? Int)!
                    print("code...", code)
                    
                    if code == 200{
                        DispatchQueue.main.async(execute: {
                            
                            let sessionData = SessionListData(json)
                            completion(sessionData, true, message)
                        })
                    }else{
                        completion(nil, false, message)
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



