//
//  CommonFxns.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/02/2022.
//

import UIKit
import Foundation

class CommonFxns: NSObject {
    // Method to change language to Selcted language at Home screen
    class func switchLanguageAtHomeScreen(){
        if LocalizationSystem.sharedInstance.getLanguage() == arabicLanguage {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: englishLanguage)
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITableView.appearance().semanticContentAttribute = .forceLeftToRight
            UISwitch.appearance().semanticContentAttribute = .forceLeftToRight
    //            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
            navController.view.semanticContentAttribute = .forceLeftToRight

            navController.navigationBar.semanticContentAttribute = .forceLeftToRight
        } else {
            LocalizationSystem.sharedInstance.setLanguage(languageCode: arabicLanguage)
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITableView.appearance().semanticContentAttribute = .forceRightToLeft
            UISwitch.appearance().semanticContentAttribute = .forceRightToLeft
    //            UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
            
            let navController:UINavigationController = appDelegate.window!.rootViewController as! UINavigationController
            navController.view.semanticContentAttribute = .forceRightToLeft
            navController.navigationBar.semanticContentAttribute = .forceRightToLeft
       }
//      let storyboard = UIStoryboard(name: mainStr, bundle: nil)
//      let homeVc = storyboard.instantiateViewController(withIdentifier: homeVCIdentifier) as! HomeVC
//      var vcArray = (appDelegate.window?.rootViewController as! UINavigationController).viewControllers
//      vcArray.removeAll()
//      vcArray.append(homeVc)
//      (appDelegate.window?.rootViewController as! UINavigationController).setViewControllers(vcArray, animated: false)
    }
    
    
    
}


