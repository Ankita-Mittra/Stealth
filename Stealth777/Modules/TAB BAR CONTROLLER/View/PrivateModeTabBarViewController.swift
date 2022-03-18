//
//  PrivateModeTabBarViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class PrivateModeTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.largeTitleDisplayMode = .always
        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chats")
        self.setSearchBarOnNavigationBar()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)

        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.largeTitleDisplayMode = .always
        self.setLargeHeaderOnNavigationBar(largeTitleHeader: "Chats")
        self.setSearchBarOnNavigationBar()
    }

//    override func willMove(toParent parent: UIViewController?) {
//        navigationController?.navigationBar.prefersLargeTitles = true
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
////        navigationController?.setNavigationBarHidden(true, animated: true)
//    }
////    
    func setLargeHeaderOnNavigationBar(largeTitleHeader: String){
        self.title = largeTitleHeader
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.navigationController?.navigationBar.sizeToFit()

    }
    
    
    func setSmallHeaderAndHideLargeHeader(header: String){
        self.title = header
        self.navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    func showNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideSearchBarFromNavigationBar(){
        navigationItem.searchController = nil
    }
    
    func setSearchBarOnNavigationBar(){
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
    }

    
}
