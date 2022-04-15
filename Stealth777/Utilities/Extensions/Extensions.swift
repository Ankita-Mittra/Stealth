//
//  Extensions.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//

import Foundation
import UIKit

// MARK: - Extension to convert string to and from base 64
extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}

// MARK: - Extension to split string into words
extension String {
    func contains(word : String) -> Bool
    {
        return self.range(of: "\\b\(word)\\b", options: .regularExpression) != nil
    }
}

// MARK: - Extension to hide keyboard on single tap on screen
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Extension to lock app on double tap on screen
extension UIViewController {
    func lockAppOnDoubleTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.showloginScreen))
        tap.numberOfTapsRequired = two
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func showloginScreen() {
        CommonFxns.popToLoginVC()
    }
}

// MARK: - Extension to add gradient on background of screen

extension UIView{
    
    func addGradient(){
        let gradientView = UIView(frame: CGRect(x: -64, y: -64, width: 320, height: 320))
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = gradientView.frame.size
        let gradientColor1 = UIColor(red: 20/255, green: 49/255, blue: 80/255, alpha: 1).cgColor
        let gradientColor2 = UIColor(red: 26/255, green: 27/255, blue: 39/255, alpha: 1).cgColor
        
        gradientLayer.colors = [gradientColor1,gradientColor2]
        gradientView.layer.addSublayer(gradientLayer)
        
        gradientLayer.startPoint = CGPoint(x: -0.8, y: -0.8)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 0.8)
        
        self.inputView?.layer.addSublayer(gradientLayer)
    }
    
}

// MARK: - Extension to force update navigation bar

extension UINavigationController {
    func forceUpdateNavBar() {
        DispatchQueue.main.async {
            self.navigationBar.sizeToFit()
        }
      }
}

// MARK: - Extension to split String into Array
extension StringProtocol {
    var words: [SubSequence]{
        
        return split { !$0.isLetter}
    }
}
