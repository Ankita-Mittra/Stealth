//
//  AppDelegate.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 24/02/2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.navigateToRightScreen()
//        self.getAppStoreVersion()

        let enabledMode = userDefault.value(forKey: USER_DEFAULT_isDarkMode_Key) as? String
        
        switch enabledMode {
        case lightMode:
            appDelegate.window?.overrideUserInterfaceStyle = .light
            userDefault.set(lightMode , forKey: USER_DEFAULT_isDarkMode_Key)
        default:
            appDelegate.window?.overrideUserInterfaceStyle = .dark
            userDefault.set(darkMode , forKey: USER_DEFAULT_isDarkMode_Key)
        }
//
//        if userDefault.value(forKey: USER_DEFAULT_isDarkMode_Key) == nil{
//
//        }
//        if let isDarkModeEnabled = userDefault.value(forKey: USER_DEFAULT_isDarkMode_Key){
//            userDefault.set(true , forKey: USER_DEFAULT_isDarkMode_Key)
//
//            appDelegate.window?.overrideUserInterfaceStyle = .dark
//        }else{
//            userDefault.set(true , forKey: USER_DEFAULT_isDarkMode_Key)
//
//            appDelegate.window?.overrideUserInterfaceStyle = .dark
//        }
//
        return true
    }
    
    func getAppStoreVersion(){
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
        print("version....", version)
        
        guard let bundleId = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String else { return }
        guard let url = URL(string: "https://itunes.apple.com/lookup?bundleId=\(bundleId)&country=br") else { return }
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data)
                    guard let json = jsonObject as? [String: Any] else {
                        print("The received that is not a Dictionary")
                        return
                    }
                    let results = json["results"] as? [[String: Any]]
                    let firstResult = results?.first
                    let currentVersion = firstResult?["version"] as? String
                    print("currentVersion: ", currentVersion)
                } catch let serializationError {
                    print("Serialization Error: ", serializationError)
                }
            } else if let error = error {
                print("Error: ", error)
            } else if let response = response {
                print("Response: ", response)
            } else {
                print("Unknown error")
            }
        }
        task.resume()
    }
    
    // MARK: Methods

    // Method tonavigate user on appropriate screen
    func navigateToRightScreen(){
        
        let userInfoDict = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String: Any]
        print("userInfoDict....", userInfoDict)

        
    // Check whether user is logged in or not
        guard  let userInfoDict = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String: Any] else {
  
            self.goToInitialScreen()
            return
        }
        
            print("userInfoDict....", userInfoDict)
            if (userInfoDict[USER_DEFAULT_userID_Key] != nil) {
//(userDefault.value(forKey: USER_DEFAULT_userID_Key)) != nil{
                let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
                let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
                let loginVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar.rawValue) as! PublicModeTabBarViewController
                navController.pushViewController(loginVcObj, animated: true)
            }else{
                // Go to Initial screen

                self.goToInitialScreen()

    //                let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
    //                let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.login.rawValue, bundle: nil)
    //                let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.login.rawValue) as! LoginViewController
    //                navController.pushViewController(signUpVcObj, animated: true)
            }
        
    }
    
    func goToInitialScreen(){
        let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
        let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.main.rawValue, bundle: nil)
        let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initial.rawValue) as! InitialViewController
        navController.pushViewController(signUpVcObj, animated: true)
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: coreDataName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }else{
                print("Successfully loaded core data.")

            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func clearStorage(forEntity entity: String) {
        let isInMemoryStore = persistentContainer.persistentStoreDescriptions.reduce(false) {
            return $0 ? true : $1.type == NSInMemoryStoreType
        }

        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        // NSBatchDeleteRequest is not supported for in-memory stores
        if isInMemoryStore {
            do {
                let entities = try managedObjectContext.fetch(fetchRequest)
                for entity in entities {
                    managedObjectContext.delete(entity as! NSManagedObject)
                }
            } catch let error as NSError {
                print(error)
            }
        } else {
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            do {
                try managedObjectContext.execute(batchDeleteRequest)
            } catch let error as NSError {
                print(error)
            }
        }
    }

}

