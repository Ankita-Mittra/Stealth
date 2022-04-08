//
//  SignUpAPIService.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 01/04/2022.
//

import Foundation
import Alamofire
import SwiftUI

// MARK: - Services

struct SignUpAPIService {
    
    func signup(parameters: [String: AnyObject], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {

        let urlString = "https://185.247.226.7./api/users/verify/test9" //https://stealth777.is/api/users/register"//"\(baseUrl)\(APIService.enumAPIEndPoints.register)" //"http://185.247.226.7./api/users/verify/test9"
        
        print(urlString)
        print(parameters)
    
        Alamofire.request(urlString, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {response in
            guard response.result.error == nil else {
                
                DispatchQueue.main.async(execute: {
                    completion(nil, false, response.result.error.debugDescription)
                })
                return
            }
            print(response)
            print(response.result.description)
        }
//
//            if let value: AnyObject = response.result.value as AnyObject? {
//                let json = JSON(value)
//
//                //                print(json)
//                var message = ""
//                if (value["message"] as AnyObject) as? String != nil {
//                    message = ((value["message"]! as AnyObject) as? String)!
//                }
//
//                if json["available"] == "yes" {
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
    }
}
    

