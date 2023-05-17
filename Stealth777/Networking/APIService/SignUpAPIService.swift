//
//  SignUpAPIService.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 01/04/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Services

struct SignUpAPIService {

     func signup(parameters: [String: Any], completion: @escaping (_ data: [String: AnyObject]?, _ succeeded: Bool, _ error: String) -> Void) {
    
        let url = baseUrl + "\(enumAPIEndPoints.register.rawValue)"
        print("url....", url)
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON {response in
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

