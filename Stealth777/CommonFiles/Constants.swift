//
//  Constants.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/02/2022.
//

import Foundation
import UIKit

// All the app costants using in code


// MARK: AppDelegate reference
let appDelegate = UIApplication.shared.delegate as!(AppDelegate)

// MARK: - UserDefault Constants

let userDefault = UserDefaults.standard

// User default Keys
let USER_DEFAULT_username_Key = "userdefault_username"
let USER_DEFAULT_walletAddress_Key = "userdefault_walletAddress"
let USER_DEFAULT_userID_Key = "userdefault_userID"



// MARK: iPhone device's size Constants

// OS type
let iOSDeviceType = 1
let appVersion = 1.8


// Screen sizes
let iPhone_8Plus_Height:CGFloat = 736
let iPhone_X_Height:CGFloat = 812
let iPhone_6_Height:CGFloat = 667

// Numbers
let zero = 0
let one = 1
let two = 2
let five = 5

// Fonts increment/decrement

let fontSizeForLargeDevices:CGFloat = 2
let fontSizeForSmallDevices:CGFloat = 2

// MARK: Colors

let usernameAlertBgGreenColor = UIColor(red: 69/250, green: 191/250, blue: 85/250, alpha: 1)

