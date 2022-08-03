//
//  CommonFxns.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/02/2022.
//

import UIKit
import Foundation
import SystemConfiguration
import SDWebImage
import SwiftyJSON
import SwiftECC
import CryptoKit

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
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
        
        CommonFxns.popToInitialVC()
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
    
    // Method to go to Initial screen
    class func popToInitialVC(){
        let storyboard = UIStoryboard(name: enumStoryBoard.main.rawValue, bundle: nil)
        let initialVc = storyboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.initial.rawValue) as! InitialViewController
        var vcArray = (appDelegate.window?.rootViewController as! UINavigationController).viewControllers
        vcArray.removeAll()
        vcArray.append(initialVc)
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
    
    // Public method to fetch token from user defaults
    class func getAuthenticationToken() -> [String: String]{
        
        let token  = userDefault.value(forKey: USER_DEFAULT_token_Key) as? String ?? emptyStr
        let headers = [
            "Authorization" : String(format: "Bearer \(token)")
        ]
        return headers
        
    }
    
    // Public method to fetch userId from user defaults
    class func getLoggedInUserId() -> String{
        
        guard  let userInfoDict = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String: Any] else {
            return emptyStr
        }
        
        let userId = userInfoDict[USER_DEFAULT_walletAddress_Key] as? String ?? emptyStr
        return userId
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
    
    class func isValidPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    // Method to check Email Validations
    class func isValidDisplayName(testStr:String) -> Bool {
        let regEx = "{4,15}$"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return nameTest.evaluate(with: testStr)
    }
    
    class func hidePassword(textField: UITextField, hide: Bool){
        if hide{
            textField.isSecureTextEntry = true
        }else{
            textField.isSecureTextEntry = false
        }
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
    
    class func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    class func encryptMsg(msg: String, publickey: String, privateKey: String)-> String{
        
        
           let newOtherUserPublicKey = "-----BEGIN PUBLIC KEY-----\n" + publickey + "\n-----END PUBLIC KEY-----"
           var encryptedText =  String()
           
           do {
               let otherUserPbkey = try ECPublicKey(pem: newOtherUserPublicKey)

               let loggedInUserPrKey = try ECPrivateKey(pem: privateKey)
                           
               print("otherUserPbkey..", otherUserPbkey)
               print("loggedInUserPrKey..", loggedInUserPrKey)
               
               let eccEncObj = EccEncryption()
       
               let importOtherUserPublicKey = try eccEncObj.importPublicKey(otherUserPbkey.pem)
               let importLoggedInUserPrivateKey = try eccEncObj.importPrivateKey(loggedInUserPrKey.pem)

               let deriveKey = try eccEncObj.deriveSymmetricKey(privateKey: importLoggedInUserPrivateKey, publicKey: importOtherUserPublicKey)
               print("deriveKey...", deriveKey)
               let sensitiveMessage = msg.data(using: .utf8)!

               let iv = CryptoKit.AES.GCM.Nonce()

               let sealedBox = try! CryptoKit.AES.GCM.seal(sensitiveMessage,
                                                 using: deriveKey,
                                                 nonce: iv)
               let cipher = sealedBox.ciphertext + sealedBox.tag
               encryptedText = cipher.base64EncodedString()
               print("encryptedText.....", encryptedText )
               
           }
            catch let error{
                print("error...", error.localizedDescription)
            }
            return encryptedText
        }

    class func swiftyECC() {
        do {
            let domain = Domain.instance(curve: .EC256r1)
            let eccEncObj = EccEncryption()

    //             // Party A's keys
            let (public_ios, private_ios) = domain.makeKeyPair()

            let priv_ios_str = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIOfZ40GOHGmWawm4Oc3eHY5k3qRrkeMfrQHQ97BiNl8CoAoGCCqGSM49\nAwEHoUQDQgAEfMH8q+EeTaadxJze+VoN8ik1b/eAAlykEVbFykPrY1x+/G0Vr6/I\nYhQbK74RpG6x9gnJKBUG4+/fJRBANNjDcQ==\n-----END EC PRIVATE KEY-----"
            let priv_iOS = try ECPrivateKey(pem: priv_ios_str)
            print("exported priv_ios...", priv_iOS.pem)
            
            let pub_iOS_str = "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEfMH8q+EeTaadxJze+VoN8ik1b/eA\nAlykEVbFykPrY1x+/G0Vr6/IYhQbK74RpG6x9gnJKBUG4+/fJRBANNjDcQ==\n-----END PUBLIC KEY-----"
            let pub_iOS = try ECPublicKey(pem: pub_iOS_str)
            print("exported pub_iOS...", pub_iOS.pem)

            // Party B's keys

            let private_android  = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIP3IeHUUAZFynG7qoZFiqX6OP/r7myLUhrE6GCc1aZEaoAoGCCqGSM49\nAwEHoUQDQgAEgTRYk9G849srpu1HE7SnM9MbP/YCkzizbp4GJmyNEV56q5uRaJMN\nTuKAVxFhCYW0ZWMt5Ju0D1svy7u7cMAUrA==\n-----END EC PRIVATE KEY-----"
    //            let pub_Android = "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEgTRYk9G849srpu1HE7SnM9MbP/YC\nkzizbp4GJmyNEV56q5uRaJMNTuKAVxFhCYW0ZWMt5Ju0D1svy7u7cMAUrA==\n-----END PUBLIC KEY-----"
            let pub_Android = "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEtmO1qMu2hdpYz2b9u5TUrDa+UEoEGtk9/sth+P4L\nVnQ2221D8jrHK2wNbTcvYGnZo6KhiEIPhFNGDsABkl8IGQ==\n-----END PUBLIC KEY-----"

            let pubKeyAndroid = try ECPublicKey(pem: pub_Android)

            let priKeyAndroid = try ECPrivateKey(pem: private_android)
            
            print("exported Pem...", pubKeyAndroid.pem)
            print("exported Pem...", priKeyAndroid.pem)


            let importPrivateKey_android = try eccEncObj.importPrivateKey(priKeyAndroid.pem)
            let importPublickey_android = try eccEncObj.importPublicKey(pubKeyAndroid.pem)
            let importPrivateKey_ios = try eccEncObj.importPrivateKey(priv_iOS.pem)
            let importPublickey_ios = try eccEncObj.importPublicKey(pub_iOS.pem)

            print("importPublickey : ", importPublickey_android.pemRepresentation)
            print("importPublickey ios : ", importPublickey_android.pemRepresentation)

            let info: Bytes = [1,2,3]
            let secretA = try private_ios.keyAgreement(pubKey: pubKeyAndroid, length: 8, md: .SHA2_256, sharedInfo: info)
            print("secret A....", secretA.description.toBase64())
            
            let deriveKey = try eccEncObj.deriveSymmetricKey(privateKey: importPrivateKey_ios, publicKey: importPublickey_android)
            print("deriveKey...", deriveKey)
            let sensitiveMessage = "HI,Shafat".data(using: .utf8)!

            let iv = CryptoKit.AES.GCM.Nonce()
            
            let sealedBox = try! CryptoKit.AES.GCM.seal(sensitiveMessage,
                                              using: deriveKey,
                                              nonce: iv)
            let cipher = sealedBox.ciphertext + sealedBox.tag
            print("cipher.....", cipher.base64EncodedString() )

            let symmetricKey = try eccEncObj.deriveSymmetricKey(privateKey: importPrivateKey_ios, publicKey: importPublickey_android)

            let sensitiveMessageAndroid = "HLlYDHImPGQi6sle96F2VOjuMgjmVLgXLrnieXo87XA=".data(using: .utf8)!
            let nonce = "O5ZPMUTqHOEXepSZ".data(using: .utf8)
            // need to prefix data with nonce, because data from kotlin/java contains the cipher text plus the tag at the end.
            // we want nonce || ciphertext || tag for CryptoKit to be happy
            let combine = nonce! + sensitiveMessageAndroid
            let myNewSealedBox = try CryptoKit.AES.GCM.SealedBox(combined: combine)
            
            let res = try CryptoKit.AES.GCM.open(myNewSealedBox, using: symmetricKey)
            let myText = try String(decoding: res, as: UTF8.self)
            print("myText...", myText)
        } catch {
            print("Exception: \(error)")
        }
    }
    
    
    class func decryptMsg(cipherText: String, publickey: String, privateKey: String)-> String{
        
        
           let newOtherUserPublicKey = "-----BEGIN PUBLIC KEY-----\n" + publickey + "\n-----END PUBLIC KEY-----"
           var decryptedText =  String()
//        self.swiftyECC()
           do {
               let otherUserPbkey = try ECPublicKey(pem: newOtherUserPublicKey)

               let loggedInUserPrKey = try ECPrivateKey(pem: privateKey)
                           
               print("otherUserPbkey..", otherUserPbkey)
               print("loggedInUserPrKey..", loggedInUserPrKey)
               
               let eccEncObj = EccEncryption()
       
               let importOtherUserPublicKey = try eccEncObj.importPublicKey(otherUserPbkey.pem)
               let importLoggedInUserPrivateKey = try eccEncObj.importPrivateKey(loggedInUserPrKey.pem)

//               let deriveKey = try eccEncObj.deriveSymmetricKey(privateKey: importLoggedInUserPrivateKey, publicKey: importOtherUserPublicKey)
//               print("deriveKey...", deriveKey)
//               let sensitiveMessage = msg.data(using: .utf8)!
//
//               let iv = CryptoKit.AES.GCM.Nonce()
//
//               let sealedBox = try! CryptoKit.AES.GCM.seal(sensitiveMessage,
//                                                 using: deriveKey,
//                                                 nonce: iv)
//               let cipher = sealedBox.ciphertext + sealedBox.tag
//               encryptedText = cipher.base64EncodedString()
//               print("encryptedText.....", encryptedText )
               
               
               let deriveKey = try eccEncObj.deriveSymmetricKey(privateKey: importLoggedInUserPrivateKey, publicKey: importOtherUserPublicKey)
               print("deriveKey..22222.", deriveKey)

               let sensitiveMessageAndroid = cipherText.data(using: .utf8)!
               let nonce = CryptoKit.AES.GCM.Nonce()
               
               
               // need to prefix data with nonce, because data from kotlin/java contains the cipher text plus the tag at the end.
               // we want nonce || ciphertext || tag for CryptoKit to be happy
               let combine = nonce + sensitiveMessageAndroid
               let myNewSealedBox = try CryptoKit.AES.GCM.SealedBox(combined: combine)
               
               let res = try CryptoKit.AES.GCM.open(myNewSealedBox, using: deriveKey)
               decryptedText = String(decoding: res, as: UTF8.self)
               print("decryptedText...", decryptedText)
               
           }
            catch let error{
                print("error...", error.localizedDescription)
            }
            return decryptedText
        }
    
    class func validateLength(text : String, size : (min : Int, max : Int)) -> Bool{
        return (size.min...size.max).contains(text.count)
    }
    
    class func setImage(imageView:UIImageView,urlString:String?,placeHolder:UIImage?){
        imageView.sd_setImage(with: URL(string: urlString ?? ""), placeholderImage:placeHolder, options: .allowInvalidSSLCertificates, completed: nil)
    }
    
    class func showConfirmationAlert(title:String,message:String,okTitle:String = AlertMessages.ALERT_OK,cancelTitle:String = AlertMessages.ALERT_CANCEL,vc:UIViewController,success:@escaping(()->Void)){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action: UIAlertAction!) in
            success()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action: UIAlertAction!) in
            vc.dismiss(animated: true)
        }))
        vc.present(refreshAlert, animated: true, completion: nil)
    }
    
    class func showAlertWithCompletion(title:String,message:String,vc:UIViewController,success:@escaping(()->Void)){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: AlertMessages.ALERT_OK, style: .default, handler: { (action: UIAlertAction!) in
            success()
        }))
        
        vc.present(refreshAlert, animated: true, completion: nil)
    }
    
    class func getDateFromMilliSeconds(mSeconds:Int64) -> String{
        let date = Date(timeIntervalSince1970: (Double(mSeconds) / 1000))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        return dateFormatter.string(from: date)
        
    }
    
    class func getMilliseconds(date:Date)->Int64{
        return Int64((date.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    class func stringFromDate(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm"
        return dateFormatter.string(from: date)
    }
    
    class func getJsonObject(strJson:String) -> JSON{
        if let data = strJson.data(using: .utf8) {
            if let jsonObject = try? JSON(data: data) {
               return jsonObject
            }
        }
        return JSON()
    }
    
}


