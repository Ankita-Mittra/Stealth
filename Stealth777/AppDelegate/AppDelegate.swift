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
        return true
    }
    
    // MARK: Methods

    func navigateToRightScreen(){
    // Check whether user is logged in or not
        let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
            if (userDefault.value(forKey: USER_DEFAULT_userID_Key)) != nil{
                let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVcObj = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                navController.pushViewController(loginVcObj, animated: true)
            }else{
                // Go to SignUP screen
//                    let loginVcObj = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//                    navController.pushViewController(loginVcObj, animated: true)
                let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
                let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.main.rawValue, bundle: nil)
                let signUpVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initial.rawValue) as! InitialViewController
                navController.pushViewController(signUpVcObj, animated: true)

//                let storyBoard = UIStoryboard.init(name: enumStoryBoard.login.rawValue, bundle: nil)
//                let navController:UINavigationController = (self.window?.rootViewController as? UINavigationController)!
//
//                let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.login.rawValue) as? LoginViewController
//                navController.navigationController?.pushViewController(objLocationSearch!, animated: true)
            }
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
        let container = NSPersistentContainer(name: "Stealth777")
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

}

