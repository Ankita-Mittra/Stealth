//
//  GroupsDatabaseQueries.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/07/2022.
//


import UIKit
import CoreData

class GroupsDatabaseQueries: NSObject {

   class func fetchAllGroupsFromLocalDB() -> [GroupsModel]{
               
        let context = appDelegate.persistentContainer.viewContext
        
        print("fetchAllContactsFromLocalDB...")
        
        var groups = [GroupsModel]()

        let fetchRequest: NSFetchRequest<Groups> = Groups.fetchRequest()

       do {
           // Peform Fetch Request
           let list = try context.fetch(fetchRequest)

  
           for item in list{
               print("item....,", item)
           }

       } catch {
           print("Unable to Fetch Workouts, (\(error))")
       }
        return groups
    }
    
    class func deleteAllGroups(){
        let context = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Groups")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("Unable to Fetch Workouts, (\(error))")
        }
    }

//
//    let id: String? // 1
//    let name: String? // 2
//    let description: String? // 3
//    let imageUrl: String? // 4
//    let disperse: Int? // 5
//    let anonymous: Int? // 6
//    let disperseDate: String? // 7
//    let canSendMsg: Int? // 8
//    let showQr: Int? // 19
//    let isPin: Int? // 10
//    let isMute: Int? // 11
//    let groupRole: Int? // 12
//    var members: [GroupMembersModel]? // 13

    class func addAndUpdateGroupsInLocalDB(groups: [GroupsModel]){
        let context = appDelegate.persistentContainer.viewContext
        groups.forEach({ group in

            do {
                let request: NSFetchRequest<Groups> = Groups.fetchRequest()
                request.predicate = NSPredicate(format: "id == %@", group.id!) // Find Group

                let groupsList = try context.fetch(request)

                if let groupInList = groupsList.first {
                    groupInList.id = group.id ?? emptyStr
                    groupInList.name = group.name ?? emptyStr
                    groupInList.desc = group.description ?? emptyStr
                    groupInList.imgUrl = group.imageUrl ?? emptyStr
                    groupInList.disperse = Int16(group.disperse ?? 0)
                    groupInList.anonymous = Int16(group.anonymous ?? 0)
                    groupInList.disperseDate = Int64(group.disperseDate ?? 0)
                    groupInList.canSendMsg = Int16(group.canSendMsg ?? 0)
                    groupInList.showQR = Int16(group.showQr ?? 0)
                    groupInList.isPin = Int16(group.isPin ?? 0)
                    groupInList.isMute = Int16(group.isMute ?? 0)
                    groupInList.groupRole = Int16(group.groupRole ?? 0)
                } else {
//                    let user = User(context: context)
//                    user.id = contact.userId ?? emptyStr
//                    user.allowWipeout = Int16(contact.allowWipeout ?? 0)//(contact.allowWipeout != nil)
//                    user.isBlock = Int16(contact.isBlock ?? 0)
//                    user.isPin = Int16(contact.isPin ?? 0)
//                    user.isMute = Int16(contact.isMute ?? 0)
//                    user.userType = Int16(contact.userType ?? zero)
//                    user.bio = contact.bio ?? emptyStr
//                    user.username = contact.username ?? emptyStr
//                    user.lastOnlineTime = Date()
//                    user.onlineStatus = Int16(contact.onlineStatus ?? 0)
//                    user.accStatus = Int16(contact.accountStatus ?? zero)
//                    user.imgUrl = contact.imageUrl ?? emptyStr
//                    user.pbKey = contact.publicKey ?? emptyStr
//                    user.wKey = contact.walletKey ?? emptyStr
                }
                try context.save()

            } catch {
                print("Failed to fetch video:", error)
            }
        })
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
