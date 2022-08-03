//
//  ChatUser.swift
//  Stealth777
//
//  Created by Manpreet Singh on 26/07/2022.
//

import Foundation

struct ChatUser{
    var id:String?
    var name:String?
    var image:String?
    init(dict:[String:String]){
        self.id = dict["id"]
        self.name = dict["name"]
        self.image = dict["image"]
    }
}
