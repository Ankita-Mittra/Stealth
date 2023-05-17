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
    var network: String?

    init(name: String, symbol: String, decimals: String, balance: String, contractAddress: String, network: String){

        self.name = name
        self.symbol = symbol
        self.decimals = decimals
        self.balance = balance
        self.contractAddress = contractAddress
        self.network = network
    }
    
    init?(dict: [String:Any]) {
        guard
            let name = dict[enumLocalDBTokenInfoKeys.name.rawValue] as? String,
            let symbol = dict[enumLocalDBTokenInfoKeys.symbol.rawValue] as? String,
            let decimals = dict[enumLocalDBTokenInfoKeys.decimals.rawValue] as? String,
            let network = dict[enumLocalDBTokenInfoKeys.network.rawValue] as? String,
            let balance = dict[enumLocalDBTokenInfoKeys.balance.rawValue] as? String,
            let contractAddress = dict[enumLocalDBTokenInfoKeys.contractAddress.rawValue] as? String else {
                    return nil
            }
        
        self.name = name
        self.symbol = symbol
        self.balance = balance
        self.contractAddress = contractAddress
        self.decimals = decimals
        self.network = network
    }
    
    init(token:TokenInfo){
        name = token.name
        balance = token.balance
        network = token.network
        symbol = token.symbol
        decimals = token.decimals
        contractAddress = token.contractAddress
    }
    
    func toAnyObject() -> Any {
        return [
            enumLocalDBTokenInfoKeys.name.rawValue : name,
            enumLocalDBTokenInfoKeys.symbol.rawValue: symbol,
            enumLocalDBTokenInfoKeys.decimals.rawValue: decimals,
            enumLocalDBTokenInfoKeys.balance.rawValue: balance,
            enumLocalDBTokenInfoKeys.contractAddress.rawValue: contractAddress,
            enumLocalDBTokenInfoKeys.network.rawValue: network
        ]
    }
}


