//
//  DeleteMessageRequest.swift
//  Stealth777
//
//  Created by Manpreet Singh on 05/08/2022.
//

import Foundation

struct DeleteMessageRequest{
    
    var forAll:Int?
    var msgId:String?
    
    init(forAll:Int,msgId:String){
        self.forAll = forAll
        self.msgId = msgId
    }
    
    func toDictionary()->[String:Any]{
        let dict:[String:Any] = ["forAll":forAll ?? 0,
                    "msgId":msgId ?? ""]
        return dict
    }
    
}
