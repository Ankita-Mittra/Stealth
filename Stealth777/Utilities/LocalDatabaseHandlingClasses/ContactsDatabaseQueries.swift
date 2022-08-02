//
//  ContactsDatabaseQueries.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 02/06/2022.
//

import UIKit
import CoreData

class ContactsDatabaseQueries: NSObject {

   class func fetchAllContactsFromLocalDB() -> [GroupParticipantsUserModel]{
               
        let context = appDelegate.persistentContainer.viewContext
        
        print("fetchAllContactsFromLocalDB...")
        
        var contacts = [GroupParticipantsUserModel]()
//        var users = User(context: context)
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: enumLocalDBIdentifires.users.rawValue)
//        request.predicate = NSPredicate(format: "UserRelation == %@", 2 )
//
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

       do {
           // Peform Fetch Request
           let users = try context.fetch(fetchRequest)

           for user in users{
               let dict = GroupParticipantsUserModel(with: user)
               contacts.append(dict)
           }
           print("users...", users)
           print("contacts...", contacts)

       } catch {
           print("Unable to Fetch Workouts, (\(error))")
       }
        return contacts
    }
    
    class func deleteUserDbData(){
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("Unable to Fetch Workouts, (\(error))")
        }
    }
    
    class func getUserByID(userId: String)-> UserModel?{
        let context = appDelegate.persistentContainer.viewContext
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", userId) // Find Contact
            
            let users = try context.fetch(request)
            let obj = UserModel(with: users.first)
            return obj
        }
        catch {
            print("Failed to fetch video:", error)
        }
        
        
        return nil
    }

//    func abc(){
//        guard let managedObjectContext = appDelegate.persistentContainer.viewContext else {
//            fatalError("No Managed Object Context Available")
//        }
//
//        // Create Book
//
//
//
//        let user = User(context: managedObjectContext)
//
//
//
////        let book = Book(context: managedObjectContext)
////
////        // Populate Book
////        book.title = titleTextField.text
////        book.author = authorTextField.text
//
//        do {
//            // Save Book to Persistent Store
//            try managedObjectContext.save()
//
//            // Dismiss View Controller
//        } catch {
//            print("Unable to Save Book, \(error)")
//        }
//    }
    
    class func addAndUpdateContactsInLocalDB(contacts: [UserModel]){
        let context = appDelegate.persistentContainer.viewContext

        
        
        /////////////////////////////
        
        contacts.forEach({ contact in

            do {
                let request: NSFetchRequest<User> = User.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", contact.userId!) // Find Contact
                
                let users = try context.fetch(request)

                if let user = users.first {
                                        
                    user.id = contact.userId ?? emptyStr
                    user.allowWipeout = Int16(contact.allowWipeout ?? 0)//(contact.allowWipeout != nil)
                    user.isBlock = Int16(contact.isBlock ?? 0)
                    user.isPin = Int16(contact.isPin ?? 0)
                    user.isMute = Int16(contact.isMute ?? 0)
                    user.userType = Int16(contact.userType ?? zero)
                    user.bio = contact.bio ?? emptyStr
                    user.username = contact.username ?? emptyStr
                    user.lastOnlineTime = Date()
                    user.onlineStatus = Int16(contact.onlineStatus ?? 0)
                    user.accStatus = Int16(contact.accountStatus ?? zero)
                    user.imgUrl = contact.imageUrl ?? emptyStr
                    user.pbKey = contact.publicKey ?? emptyStr
                    user.wKey = contact.walletKey ?? emptyStr
                    
                } else {
                    let user = User(context: context)
                    
                    user.id = contact.userId ?? emptyStr
                    user.allowWipeout = Int16(contact.allowWipeout ?? 0)//(contact.allowWipeout != nil)
                    user.isBlock = Int16(contact.isBlock ?? 0)
                    user.isPin = Int16(contact.isPin ?? 0)
                    user.isMute = Int16(contact.isMute ?? 0)
                    user.userType = Int16(contact.userType ?? zero)
                    user.bio = contact.bio ?? emptyStr
                    user.username = contact.username ?? emptyStr
                    user.lastOnlineTime = Date()
                    user.onlineStatus = Int16(contact.onlineStatus ?? 0)
                    user.accStatus = Int16(contact.accountStatus ?? zero)
                    user.imgUrl = contact.imageUrl ?? emptyStr
                    user.pbKey = contact.publicKey ?? emptyStr
                    user.wKey = contact.walletKey ?? emptyStr
                }
                try context.save()

            } catch {
                print("Failed to fetch video:", error)
            }
        })
        
//        ///////////////////////////
//        for contact in contacts{
//
//            if let foundDict = contacts.firstIndex(where: {$0.userId == contact.userId}) {
//                    print("foundDict", foundDict)
//            }else{
//                let user = User(context: context)
//
//                user.id = contact.userId ?? emptyStr
//                user.allowWipeout = Int16(contact.allowWipeout ?? 0)//(contact.allowWipeout != nil)
//                user.isBlock = Int16(contact.isBlock ?? 0)
//                user.isPin = Int16(contact.isPin ?? 0)
//                user.isMute = Int16(contact.isMute ?? 0)
//                user.userType = Int16(contact.userType ?? zero)
//                user.bio = contact.bio ?? emptyStr
//                user.username = contact.username ?? emptyStr
//                user.lastOnlineTime = Date()
//                user.onlineStatus = Int16(contact.onlineStatus ?? 0)
//                user.accStatus = Int16(contact.accountStatus ?? zero)
//                user.imgUrl = contact.imageUrl ?? emptyStr
//                user.pbKey = contact.publicKey ?? emptyStr
//                user.wKey = contact.walletKey ?? emptyStr
//            }
//        }
//
//        do {
//            // Save Contacts to Persistent Store
//            try context.save()
//            print("saved")
//        } catch {
//            print("Unable to Save Book, \(error)")
//        }
    }
    
    func updateUserRelationStatus(userId: String, relationStatus: String){
        print("updateUserRelationStatus...")
        
        let context = appDelegate.persistentContainer.viewContext
        print("fetchAllContactsFromLocalDB...")
        
        var contacts = [UserModel]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: userId_API_key)
        request.predicate = NSPredicate(format: "relation == %@", "" )
        // fetch users and sort contacts
    }
    
    
}
