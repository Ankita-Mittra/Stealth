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
   
        let url = baseUrl + "\(enumAPIEndPoints.getAllGroups.rawValue)"
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
    
    func uploadGroupImage(image: UIImage, imageName: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
        
        let url = baseUrl + "\(enumAPIEndPoints.uploadFile.rawValue)"
        print("url....", url)
        let headers = CommonFxns.getAuthenticationToken()
//        let parameters = ["name": ""] //Optional for extra parameter

        guard let imgData = image.jpegData(compressionQuality: 0.1) else { return }

        Alamofire.upload(multipartFormData: { multipartFormData in
            //Parameter for Upload files
            multipartFormData.append(imgData, withName: "file",fileName: "furkan.png" , mimeType: "image/png")
            
//            for (key, value) in parameters
//            {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            }
            
        }, usingThreshold:UInt64.init(),
           to: url,
            method: .post,
            headers: headers,
            encodingCompletion: { (result) in
                
                switch result {
                case .success(let upload, _, _):
                    print("the status code is :")
                    
                    upload.uploadProgress(closure: { (progress) in
                        print("something")

                    })
                    
                    upload.responseJSON { result in
                        print("the resopnse code is : \(result.response?.statusCode)")
                        print("the response is : \(result)")
                        
                        if let dict = result.value  as? [String: AnyObject]{
                            if let data = dict["data"] as? [String: Any]{
                                print("data:...", data)
                                
                                let mediaId = data["id"] as? String
                                
                                
                                
                                let json = JSON(data)

                                completion(json.dictionaryObject as [String: AnyObject]?, true, "success")

                                
                                
                            }
                        }
        
                    }
                    break
                case .failure(let encodingError):
                    
                    
                    DispatchQueue.main.async(execute: {
                        
                        completion(nil, false, encodingError.localizedDescription)
                    })
                    return
                    
                }
        })

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
    //     "groupId": "a533e714-3868-465d-842a-9b5976658ec2",
  //  "members": ["1d351aeb-25d8-42d0-aad4-f7c8cc70ace0"]
    // groups/members?groupId=d2164248-6158-4468-8bfa-ad9f79773381
    
    func getAllGroupMembers(groupId: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.getAllGroupMembers.rawValue)" + "\(groupId)"
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

    func addMembersInGroup(memberIds: [String], groupId: String,completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.addMembers.rawValue)"
        print("url....", url)
        print("groupId ... and members...", groupId, memberIds)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [groupId_API_key : groupId, "members" : memberIds] as [String : Any]

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
    
    func removeMembersInGroup(userId: String, groupId: String,completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.removeMembers.rawValue)"
        print("url....", url)
        print("groupId ... and user...", groupId, userId)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [groupId_API_key : groupId, "userId" : userId] as [String : Any]

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
    
    func deleteGroup(groupId: String,completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.deleteGroup.rawValue)"
        print("url....", url)
        print("groupId ...", groupId)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [groupId_API_key : groupId] as [String : Any]

         Alamofire.request(url, method: .delete, parameters: parmeters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
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
    
    func exitGroup(groupId: String,completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.exitGroup.rawValue)"
        print("url....", url)
        print("groupId ...", groupId)

        let headers = CommonFxns.getAuthenticationToken()
        let parmeters = [groupId_API_key : groupId] as [String : Any]

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
    
    func setGroupAdmin(parameters:[String:Any],completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
        let url = baseUrl + "\(enumAPIEndPoints.setAdmin.rawValue)"
        print("url....", url)
        print("parameters ...", parameters)

        let headers = CommonFxns.getAuthenticationToken()
         Alamofire.request(url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON {response in
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
