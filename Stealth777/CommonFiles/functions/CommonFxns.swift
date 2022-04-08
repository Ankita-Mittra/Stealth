//
//  CommonFxns.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/02/2022.
//

import UIKit
import Foundation
import SystemConfiguration

class CommonFxns: NSObject {

    // Method to change language to Selcted language at Home screen
    class func switchLanguageAtHomeScreen(selectedLanguageCode: String){
        
        
        switch selectedLanguageCode {
            
        case enumLanguageCodes.arabicLanguage.rawValue:
            
            LocalizationSystem.sharedInstance.setLanguage(languageCode: enumLanguageCodes.arabicLanguage.rawValue)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
//            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
            navController.view.semanticContentAttribute = .forceRightToLeft
            navController.navigationBar.semanticContentAttribute = .forceRightToLeft
            
        case enumLanguageCodes.french.rawValue:
            LocalizationSystem.sharedInstance.setLanguage(languageCode: enumLanguageCodes.french.rawValue)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
//            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
            navController.view.semanticContentAttribute = .forceLeftToRight

            navController.navigationBar.semanticContentAttribute = .forceLeftToRight
            
        case enumLanguageCodes.dutch.rawValue:
            LocalizationSystem.sharedInstance.setLanguage(languageCode: enumLanguageCodes.dutch.rawValue)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
//            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
            navController.view.semanticContentAttribute = .forceLeftToRight

            navController.navigationBar.semanticContentAttribute = .forceLeftToRight
            
        case enumLanguageCodes.simplifiedChinese.rawValue:
            LocalizationSystem.sharedInstance.setLanguage(languageCode: enumLanguageCodes.simplifiedChinese.rawValue)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
//            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
            navController.view.semanticContentAttribute = .forceLeftToRight

            navController.navigationBar.semanticContentAttribute = .forceLeftToRight
            
        default:

            LocalizationSystem.sharedInstance.setLanguage(languageCode: enumLanguageCodes.englishLanguage.rawValue)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
//            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
            navController.view.semanticContentAttribute = .forceLeftToRight

            navController.navigationBar.semanticContentAttribute = .forceLeftToRight
            
        }
        
//        if LocalizationSystem.sharedInstance.getLanguage() == enumLanguageCodes.arabicLanguage.rawValue {
//            LocalizationSystem.sharedInstance.setLanguage(languageCode: enumLanguageCodes.englishLanguage.rawValue)
//            UIView.appearance().semanticContentAttribute = .forceLeftToRight
//            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
//            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
////            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
//
//            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
//            navController.view.semanticContentAttribute = .forceLeftToRight
//
//            navController.navigationBar.semanticContentAttribute = .forceLeftToRight
//        } else {
//            LocalizationSystem.sharedInstance.setLanguage(languageCode: enumLanguageCodes.arabicLanguage.rawValue)
//            UIView.appearance().semanticContentAttribute = .forceRightToLeft
//            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
//            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
////            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
//
//            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
//            navController.view.semanticContentAttribute = .forceRightToLeft
//            navController.navigationBar.semanticContentAttribute = .forceRightToLeft
//       }

        let storyboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let tabBarControllerObj = storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar .rawValue) as! PublicModeTabBarViewController
        var vcArray = (appDelegate.window?.rootViewController as! UINavigationController).viewControllers
        vcArray.removeAll()
        vcArray.append(tabBarControllerObj)
        (appDelegate.window?.rootViewController as! UINavigationController).setViewControllers(vcArray, animated: false)
    }
    
    // Method to LogOut from App and clear all the saved data
    class func directLogOut(){
//        let uid = (Auth.auth().currentUser?.uid)!
//        do{
//            CommonFxns.setOnlineOfflineStatus(status: false) // Update online/offline status of loggedIn user
//
//            try Auth.auth().signOut()
//            removeDeviceTokenFromDB(uid: uid)
//            let deviceToken = userDefault.value(forKey: USER_DEFAULT_FireBaseToken) as? String
//            let selectedLang = LocalizationSystem.sharedInstance.getLanguage()
//            // self.updateDeviceTokenFlow()
//            let keys = userDefault.array(forKey: USER_DEFAULT_KeyPairs_Key) as? [[String: Any]]
//
//            let domain = Bundle.main.bundleIdentifier!
//            UserDefaults.standard.removePersistentDomain(forName: domain)
//            UserDefaults.standard.synchronize()
//            userDefault.set(nil, forKey: USER_DEFAULT_Logged_In_userId_Key)
//
//            userDefault.set(deviceToken, forKey: USER_DEFAULT_FireBaseToken)
//            LocalizationSystem.sharedInstance.setLanguage(languageCode: selectedLang)
//            userDefault.set(keys, forKey: USER_DEFAULT_KeyPairs_Key)
//            CommonFxns.setOnlineOfflineStatus(status: false) // Update online/offline status of loggedIn user
//            CommonFxns.popToLoginVC()
//        }catch let err{
//            print("Background error","Sign out", err)
//        }
        
        CommonFxns.popToLoginVC()
    }
    
    // Method to go to Login screen
    class func popToLoginVC(){
        let storyboard = UIStoryboard(name: enumStoryBoard.login.rawValue, bundle: nil)
        let loginVc = storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.login.rawValue) as! LoginViewController
        var vcArray = (appDelegate.window?.rootViewController as! UINavigationController).viewControllers
        vcArray.removeAll()
        vcArray.append(loginVc)
        (appDelegate.window?.rootViewController as! UINavigationController).setViewControllers(vcArray, animated: false)
    }
    
    // Method to go to Home screen
    class func popToHomeVC(){
        let storyboard = UIStoryboard(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let tabVc = storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar.rawValue) as! PublicModeTabBarViewController
        var vcArray = (appDelegate.window?.rootViewController as! UINavigationController).viewControllers
        vcArray.removeAll()
        vcArray.append(tabVc)
        (appDelegate.window?.rootViewController as! UINavigationController).setViewControllers(vcArray, animated: false)
    }
    
    // Method to check internet connectivity
    class func isInternetAvailable() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    class func overrideApplicationThemeStyle() {
        let enabledMode = userDefault.value(forKey: USER_DEFAULT_isDarkMode_Key) as? String
        
        switch enabledMode {
        case "light":
            appDelegate.window?.overrideUserInterfaceStyle = .light
            userDefault.set("light" , forKey: USER_DEFAULT_isDarkMode_Key)
        default:
            appDelegate.window?.overrideUserInterfaceStyle = .dark
            userDefault.set("dark" , forKey: USER_DEFAULT_isDarkMode_Key)
        }
    }
    
    // Method to Show default Alert view with message
    class func showAlert (_ reference:UIViewController, message:String, title:String){
        var alert = UIAlertController()
        if title == "" {
            alert = UIAlertController(title: nil, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        else{
            alert = UIAlertController(title: title, message: message,preferredStyle: UIAlertController.Style.alert)
        }
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        reference.present(alert, animated: true, completion: nil)
    }
    
    
    // Method to trim Strings
    class func trimString(string:String) -> String{
        return string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    // Method to check Email Validations
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"// "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // Method to check password Validations
    class func isValidPwd(str:String)->Bool{
        var valid = true
        let whitespace = NSCharacterSet.whitespaces
        let range = str.rangeOfCharacter(from: whitespace)

        // range will be nil if no whitespace is found
        if range != nil {
            valid = false
        } else {
            valid = true
        }
        return valid
    }
    
    // Method to check Email Validations
    class func isValidUsername(username:String) -> Bool {
        let emailRegEx = "^[0-9a-zA-Z]{4,25}$" // "^[0-9a-zA-Z\\_]{4,15}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//        if !emailTest.evaluate(with: username){
//            self.showAlert((appDelegate.window?.rootViewController)!, message: "Please enter valid username", title: "Alert")
//        }
        return emailTest.evaluate(with: username)
    }
    
    // Method to check Email Validations
    class func isValidDisplayName(testStr:String) -> Bool {
        let regEx = "{4,15}$"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return nameTest.evaluate(with: testStr)
    }
    
    class func isVPNActive() -> Bool {
        
        let vpnProtocolsKeysIdentifiers = [
            "tap", "tun", "ppp", "ipsec", "utun"
        ]
        
        guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
        let nsDict = cfDict.takeRetainedValue() as NSDictionary
        guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
            let allKeys = keys.allKeys as? [String] else { return false }

        // Checking for tunneling protocols in the keys
        for key in allKeys {
            for protocolId in vpnProtocolsKeysIdentifiers
                where key.starts(with: protocolId) {
                return true
            }
        }
        return false
    }
    
}


