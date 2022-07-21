//
//  AppWireframe+PrivateChat.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/03/2022.
//

import UIKit

extension AppWireframe {
    struct PrivateChat {
        fileprivate static let storyboardName = enumStoryBoard.privateChat.rawValue
                
        static func makeView() -> PrivateChatViewController? {
            let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
            guard let privateChatViewController = storyboard.instantiateInitialViewController() as? PrivateChatViewController else { return nil }
            return privateChatViewController
        }
        
        static func push(in navigationController: UINavigationController) {
            guard let notificationsViewController = makeView() else { return }
            navigationController.pushViewController(notificationsViewController, animated: true)
        }
    }
}
