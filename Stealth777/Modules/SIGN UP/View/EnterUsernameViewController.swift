//
//  EnterUsernameViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit
import SwiftUI

class EnterUsernameViewController: BaseViewController {

    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
//
//
//    func addGradient(viewToAddGradient: UIView){
//
//        let layer = CAGradientLayer()
//        layer.frame = CGRect(x: -64, y: -64, width: 312, height: 312)
//        layer.colors = [UIColor.red.cgColor]
//
//        self.view.layerWillDraw(layer)
//
//        viewToAddGradient.layer.addSublayer(layer)
//
//        viewToAddGradient.layer.mask = layer
//        viewToAddGradient.layer.masksToBounds = true
//
//
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//
////        let barButtonMenu = UIMenu(title: "", children: [
////            UIAction(title: NSLocalizedString("Copy", comment: ""), image: UIImage(systemName: "doc.on.doc"), handler: menuHandler),
////            UIAction(title: NSLocalizedString("Rename", comment: ""), image: UIImage(systemName: "pencil"), handler: menuHandler),
////            UIAction(title: NSLocalizedString("Duplicate", comment: ""), image: UIImage(systemName: "plus.square.on.square"), handler: menuHandler),
////            UIAction(title: NSLocalizedString("Move", comment: ""), image: UIImage(systemName: "folder"), handler: menuHandler)
////        ])
////        optionsBarItem.menu = barButtonMenu
//
//
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
//        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
//        let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(addTapped))
//
//        navigationItem.rightBarButtonItems = [add, play]
//
//
//
//}

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Create Account"
//        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func addTapped(){
        
    }
    
//    func initialSetup(){
//        self.navigationController?.title = "Create Account"
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.backItem?.leftBarButtonItem?.tintColor = .green
//    }
//    
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {

        let storyBoard = UIStoryboard.init(name: enumStoryBoard.enterPassword.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.enterPassword .rawValue) as? EnterPasswordViewController
        self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension UIView{
    
    func addGradient(){
        var gradientView = UIView(frame: CGRect(x: -64, y: -64, width: 320, height: 320))
        let gradientLayer:CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = gradientView.frame.size
        let gradientColor1 = UIColor(red: 20/255, green: 49/255, blue: 80/255, alpha: 1).cgColor
        let gradientColor2 = UIColor(red: 26/255, green: 27/255, blue: 39/255, alpha: 1).cgColor

        
        gradientLayer.colors = [gradientColor1,gradientColor2]
        
        
//        gradientLayer.colors = [UIColor.blue.cgColor,UIColor.red.cgColor]

        
//        [UIColor.blue.cgColor,UIColor.black.withAlphaComponent(1).cgColor]
//        gradientLayer.backgroundColor = CGColor(red: 20, green: 49, blue: 80, alpha: 1)

        //Use diffrent colors
        gradientView.layer.addSublayer(gradientLayer)
        
        gradientLayer.startPoint = CGPoint(x: -0.8, y: -0.8)
        gradientLayer.endPoint = CGPoint(x: 0.6, y: 0.8)
        
        
        self.inputView?.layer.addSublayer(gradientLayer)
//        self.window?.rootViewController?.view.layer.addSublayer(gradientLayer)
//            .layer.addSublayer(gradientLayer)
    }
    
}

