//
//  WebService.swift
//  Stealth777
//
//  Created by Manpreet Singh on 25/07/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebService {
    func get(url: String, params: Dictionary<String, Any>?, completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        webService(url: url, method: .get, params: params, completion: completion, failed: failed)
    }
    
    func post(url: String, params: Dictionary<String, Any>?, completion:@escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        webService(url: url, method: .post, params: params, completion: completion, failed: failed)
    }
    
    func put(url: String, params: Dictionary<String, Any>?, completion:@escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        webService(url: url, method: .put, params: params, completion: completion, failed: failed)
    }
    
    func delete(url: String, params: Dictionary<String, Any>?, completion:@escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        webService(url: url, method: .delete, params: params, completion: completion, failed: failed)
    }
    
    func uploadFilePost(url: String, params: Dictionary<String, Any>?, files: [UploadFile], completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        upload(url: url, method: .post, params: params, files: files, completion: completion, failed: failed)
    }
    
    private func webService(url: String, method: Alamofire.HTTPMethod, params: Dictionary<String, Any>?, completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        print(url)
        if(params != nil)
        {
            print(params!)
        }
        if(CommonFxns.isInternetAvailable()){
            var encoding: ParameterEncoding?
            if(method == .get){
                encoding = URLEncoding.default
            }
            else{
                encoding = JSONEncoding.default
            }
            let header = CommonFxns.getAuthenticationToken()
            Alamofire.request(url, method: method, parameters: params, encoding: encoding!, headers: header)
                .validate(statusCode: 200...299)
                .responseJSON {response in
                    guard response.result.error == nil else {
                        
                        DispatchQueue.main.async(execute: {
                            
                            CommonFxns.dismissProgress()
                            failed(response.result.error.debugDescription)
                            
                        })
                        
                        return
                    }
                    self.handleResponse(response: response, completion: completion, failed: failed)
                }
        }
        else{
            failed("No Network")
            return
        }
    }

    private func upload(url: String, method: Alamofire.HTTPMethod, params: Dictionary<String, Any>?, files: [UploadFile], completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        if !(CommonFxns.isInternetAvailable()){
            failed("No Network")
            return
        }
        if(params != nil){
            print(params!)
        }
        Alamofire.upload(multipartFormData: { formData in
            if let parameters = params {
                for (key, value) in parameters
                {
                    if let temp = value as? String {
                        formData.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? Int {
                        formData.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                }
            }
            
            for file in files
            {
                formData.append(file.data ?? Data(), withName: file.imageKey ?? "", fileName: file.fileName!, mimeType: file.mimeType!)
            }
        }, usingThreshold:UInt64.init(),
                         to: url,
                         method: method,
                         headers: CommonFxns.getAuthenticationToken(),
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
                    self.handleResponse(response: result, completion: completion, failed: failed)
                }
                break
            case .failure(let error):
                
                failed(error.localizedDescription)
                
                return
            }
        })        
    }

    private func handleResponse(response: DataResponse<Any>, completion: @escaping (JSON?) -> Void, failed: @escaping (String) -> Void){
        CommonFxns.dismissProgress()
        
        switch response.result {
        case .success:
            if let value = response.value as? [String: AnyObject] {
                let data = value["data"] as AnyObject
                if !JSON(data).isEmpty{
                    completion(JSON(data))
                }
                else{
                    completion(JSON(value))
                }
            }
            else if let array = response.value as? Array<Any>
            {
                completion(JSON(array))
            }
            else
            {
                failed("Please try again later")
                return
            }
        case .failure(_):
            if let value = response.data?.toDictionary() {
                
                if let message = value["message"] as? String
                {
                    failed(message)
                }
                else {
                    failed("Please try again later")
                }
            }
            else
            {
                failed("Please try again later")
                return
            }
        }
    }
    
    
}
