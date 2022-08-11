//
//  WalletDatabaseQueries.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/08/2022.
//

import UIKit
import CoreData

class WalletDatabaseQueries: NSObject {

    class func fetchAllImportedTokensFromLocalDB() -> [ImportedTokenList]{
                
         let context = appDelegate.persistentContainer.viewContext
         
         print("fetchAllContactsFromLocalDB...")
         
         var importedTokens = [ImportedTokenList]()
         let fetchRequest: NSFetchRequest<TokenInfo> = TokenInfo.fetchRequest()

        do {
            // Peform Fetch Request
            let tokens = try context.fetch(fetchRequest)

            for token in tokens{
                let dict = ImportedTokenList(token: token)
                importedTokens.append(dict)
            }
            print("importedTokens...", importedTokens)
        } catch {
            print("Unable to Fetch Workouts, (\(error))")
        }
         return importedTokens
     }
     
    class func saveImportedTokenForLoggedInUser(tokenInfoDict: ImportedTokenList){
        var userTokenInfoList = [[String:Any]]()
        var alreadyExisted = false
        if let tokenArr = userDefault.value(forKey: USER_DEFAULT_userTokensList_Key) as? [[String: Any]]{
            if let foundDict = tokenArr.first(where: {$0[USER_DEFAULT_tokenContractAddress_Key] as? String == tokenInfoDict.contractAddress}) {
                print("foundDict", foundDict)
                alreadyExisted = true
            }
            print("tokenArr....", tokenArr)
            userTokenInfoList.append(contentsOf: tokenArr)
        }
        print("alreadyExisted...", alreadyExisted)
        if !alreadyExisted{
            if let dict = tokenInfoDict.toAnyObject() as? [String : Any] {
                userTokenInfoList.append(dict)
                print("step 2")
                print("tokenInfoObject....", dict)
                userDefault.set(userTokenInfoList, forKey: USER_DEFAULT_userTokensList_Key)
            }
        }
    }
    
    class func addAndUpdateTokensInLocalDB(token: ImportedTokenList){
        let context = appDelegate.persistentContainer.viewContext
//        tokens.forEach({ token in
//
//        })
        do {
            let request: NSFetchRequest<TokenInfo> = TokenInfo.fetchRequest()
            request.predicate = NSPredicate(format: "contractAddress == %@", token.network!) // Find network of selected network

            let importedTokens = try context.fetch(request)
            
            if let tokenInfo = importedTokens.first {
                tokenInfo.name = token.name
                tokenInfo.symbol = token.symbol
                tokenInfo.balance = token.balance
                tokenInfo.contractAddress = token.contractAddress
                tokenInfo.decimals = token.decimals
                tokenInfo.network = token.network
            } else {
                let tokenInfo = TokenInfo(context: context)
                tokenInfo.name = token.name
                tokenInfo.symbol = token.symbol
                tokenInfo.balance = token.balance
                tokenInfo.contractAddress = token.contractAddress
                tokenInfo.decimals = token.decimals
                tokenInfo.network = token.network
            }
            try context.save()
        } catch {
            print("Failed to fetch video:", error)
        }
    }

}
