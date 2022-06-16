//
//  GroupsAPIServices.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 03/06/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreVideo

// MARK: - Services

struct GroupsAPIServices {

    func getGroupInvitations(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.getGroupInvitations.rawValue)"
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
    
    
    func getAllGroups(completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.createGroup.rawValue)"
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

    
    func respondGroupRequest(groupId: String, status: Int,completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.responseInvitaions.rawValue)"
        print("url....", url)
        print("userId..action..", groupId, status)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [groupId_API_key : groupId, status_API_key : status] as [String : Any]

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
    
    func createGroup(parameters: [String: Any],completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.createGroup.rawValue)"
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
    
}
