//
//  ImportedTokenList.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 23/05/2022.
//

import Foundation

struct ImportedTokenList {
    
    var name : String?
    var symbol: String?
    var decimals: String?
    var balance: String?
    var contractAddress: String?
    
    init(name: String, symbol: String,decimals: String, balance: String, contractAddress: String){

        self.name = name
        self.symbol = symbol
        self.decimals = decimals
        self.balance = balance
        self.contractAddress = contractAddress
    }
    
    init?(dict: [String:Any]) {
        guard
            let name = dict[USER_DEFAULT_tokenName_Key] as? String,
            let symbol = dict[USER_DEFAULT_tokenSymbol_Key] as? String,
            let decimals = dict[USER_DEFAULT_tokenPrecision_Key] as? String,
            let balance = dict[USER_DEFAULT_tokenBalance_Key] as? String,
            let contractAddress = dict[USER_DEFAULT_tokenContractAddress_Key] as? String else {
                    return nil
            }
        
        self.name = name
        self.symbol = symbol
        self.balance = balance
        self.contractAddress = contractAddress
        self.decimals = decimals
    }
    
    func toAnyObject() -> Any {
        return [
            USER_DEFAULT_tokenName_Key: name,
            USER_DEFAULT_tokenSymbol_Key: symbol,
            USER_DEFAULT_tokenPrecision_Key: decimals,
            USER_DEFAULT_tokenBalance_Key: balance,
            USER_DEFAULT_tokenContractAddress_Key: contractAddress
        ]
    }
}


