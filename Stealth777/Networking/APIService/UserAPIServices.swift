//
//  UserAPIServices.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/04/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Services

struct UserAPIServices {

     func verifyUsername(username: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
    
        let url = baseUrl + "\(enumAPIEndPoints.verifyUsername.rawValue)\(username)"
        print("url....", url)
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {response in
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
    
    func searchUser(username: String, completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
   
       let url = baseUrl + "\(enumAPIEndPoints.search.rawValue)"
       print("url....", url)
        print("username...", username)
        
       print("headers....", CommonFxns.getAuthenticationToken())
        
        let headers = CommonFxns.getAuthenticationToken()
        
        let parmeters = [name_API_key : username]

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





//struct SignUpAPIService {
//
//    // MARK: - Services
//
//    func signup(parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
//
//        let url = baseUrl + "\(enumAPIEndPoints.register)"
//
//
//        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {response in
//            guard response.result.error == nil else {
//
//                DispatchQueue.main.async(execute: {
//                    completion(nil, false, response.result.error.debugDescription)
//                })
//                return
//            }
//            print(response.result.description)
//
//            if let value: AnyObject = response.result.value as AnyObject? {
//                let json = JSON(value)
//
//                var message = ""
//                if (value["message"] as AnyObject) as? String != nil {
//                    message = ((value["message"]! as AnyObject) as? String)!
//                    print("message...", message)
//                }
//
//                if (json["success"] as? Bool)!{ // == true
//                    DispatchQueue.main.async(execute: {
//                        completion(json.dictionaryObject as [String: AnyObject]?, true, message)
//                    })
//                } else {
//                    completion(json.dictionaryObject as [String: AnyObject]?, false, message)
//                }
//            } else {
//                completion(nil, false, response.result.error.debugDescription)
//            }
//        }
//    }
//
//    func signup2(parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
//
//        let urlString = "https://www.stealth777.is/api/users/register"
//
//        print(urlString)
//        print(parameters)
//
//        Alamofire.request(urlString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {response in
//            guard response.result.error == nil else {
//
//                DispatchQueue.main.async(execute: {
//                    completion(nil, false, response.result.error.debugDescription)
//                })
//                return
//            }
//            print(response)
//            print(response.result.description)
//
//
//            //
//            //            if let value: AnyObject = response.result.value as AnyObject? {
//            //                let json = JSON(value)
//            //
//            //                //                print(json)
//            //                var message = ""
//            //                if (value["message"] as AnyObject) as? String != nil {
//            //                    message = ((value["message"]! as AnyObject) as? String)!
//            //                }
//            //
//            //                if json["available"] == "yes" {
//            //                    DispatchQueue.main.async(execute: {
//            //                        completion(json.dictionaryObject as [String: AnyObject]?, true, message)
//            //                    })
//            //                } else {
//            //                    completion(json.dictionaryObject as [String: AnyObject]?, false, message)
//            //                }
//            //            } else {
//            //                completion(nil, false, response.result.error.debugDescription)
//            //            }
//
//            //        }
//
//        }
//
//    }
//}
    

