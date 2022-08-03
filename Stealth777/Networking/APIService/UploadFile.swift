//
//  UploadFile.swift
//  Stealth777
//
//  Created by Manpreet Singh on 03/08/2022.
//

import Foundation

class UploadFile: NSObject {
    var data: Data?
    var imageKey: String?
    var mimeType: String?
    var fileName: String?
    
    override init() {
        super.init()
    }
}
