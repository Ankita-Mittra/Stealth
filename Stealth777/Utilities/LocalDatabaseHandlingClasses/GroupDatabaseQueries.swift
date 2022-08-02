//
//  GroupDatabaseQueries.swift
//  Stealth777
//
//  Created by Manpreet Singh on 02/08/2022.
//

import Foundation
import CoreData

class GroupDatabaseQueries{
    
    class func getGroupByID(groupId: String)-> GroupsModel?{
        let context = appDelegate.persistentContainer.viewContext
        do {
            let request: NSFetchRequest<Groups> = Groups.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", groupId) // Find Group
            
            let groups = try context.fetch(request)
            let obj = GroupsModel(group: groups.first)
            return obj
        }
        catch {
            print("Failed to fetch video:", error)
        }
        
        
        return nil
    }
    
    class func isGroupExist(id: String) -> Bool {
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Groups")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        let res = try! context.fetch(fetchRequest)
        return res.count > 0 ? true : false
    }
    
    class func addAndUpdateGroupsToLocalDB(groups:[GroupsModel]){
        let context = appDelegate.persistentContainer.viewContext
       
        for obj in groups{
            do{
            let request: NSFetchRequest<Groups> = Groups.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", obj.id!) // Find Contact
            
            let localGrps = try context.fetch(request)

            if let groupObj = localGrps.first {
                groupObj.anonymous = Int16(obj.anonymous ?? 0)
                groupObj.desc = obj.description
                groupObj.disperse = Int16(obj.disperse ?? 0)
                groupObj.disperseDate = obj.disperseDate
                groupObj.imgUrl = obj.imageUrl
                groupObj.thumbUrl = obj.thumbUrl
                groupObj.id = obj.id
                groupObj.isMute = Int16(obj.isMute ?? 0)
                groupObj.isPin = Int16(obj.isPin ?? 0)
                groupObj.name = obj.name
                groupObj.sendMessage = Int16(obj.canSendMsg ?? 0)
                groupObj.showQR = Int16(obj.showQr ?? 0)
                //groupObj.status = Int16(obj.sta ?? 0)
                groupObj.groupRole = Int16(obj.groupRole ?? 0)
                var groupMembers = [GroupMembers]()
                for m in obj.members ?? []{
                    let member = GroupMembers(context: context)
                    member.bio = m.bio
                    member.username = m.username ?? ""
                    member.userId = m.id
                    member.imgUrl = m.imageUrl
                    member.thumbUrl = m.thumbUrl
                    member.groupRole = Int16(m.groupRole ?? 0)
                    groupMembers.append(member)
                }
                groupObj.groupMembers = NSSet.init(array: groupMembers)
            }
            else{
                
                
                    let groupObj = Groups(context: context)
                    groupObj.anonymous = Int16(obj.anonymous ?? 0)
                    groupObj.desc = obj.description
                    groupObj.disperse = Int16(obj.disperse ?? 0)
                    groupObj.disperseDate = obj.disperseDate
                    groupObj.imgUrl = obj.imageUrl
                    groupObj.thumbUrl = obj.thumbUrl
                    groupObj.id = obj.id
                    groupObj.isMute = Int16(obj.isMute ?? 0)
                    groupObj.isPin = Int16(obj.isPin ?? 0)
                    groupObj.name = obj.name
                    groupObj.sendMessage = Int16(obj.canSendMsg ?? 0)
                    groupObj.showQR = Int16(obj.showQr ?? 0)
                    //groupObj.status = Int16(obj.sta ?? 0)
                    groupObj.groupRole = Int16(obj.groupRole ?? 0)
                    var groupMembers = [GroupMembers]()
                    for m in obj.members ?? []{
                        let member = GroupMembers(context: context)
                        member.bio = m.bio
                        member.username = m.username ?? ""
                        member.userId = m.id
                        member.imgUrl = m.imageUrl
                        member.thumbUrl = m.thumbUrl
                        member.groupRole = Int16(m.groupRole ?? 0)
                        groupMembers.append(member)
                    }
                    groupObj.groupMembers = NSSet.init(array: groupMembers)
            }
                    try context.save()
                }
                catch {
                    print("Failed to save message", error)
                }
            }
        }
        
    
    
    class func fetchGroups()->[GroupsModel] {
        let context = appDelegate.persistentContainer.viewContext
        var groups = [GroupsModel]()
        let fetchRequest: NSFetchRequest<Groups> = Groups.fetchRequest()
        do {
            // Peform Fetch Request
            let localGroups = try context.fetch(fetchRequest)
            for m in localGroups{
              let obj = GroupsModel(group: m)
                groups.append(obj)
            }
           
        } catch {
            print("Unable to Fetch Groups, (\(error))")
        }
        return groups
    }
    
    
   
    
}
