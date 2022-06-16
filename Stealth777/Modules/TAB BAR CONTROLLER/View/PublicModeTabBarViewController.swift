//
//  PublicModeTabBarViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class PublicModeTabBarViewController: UITabBarController {

    // MARK: - View Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = false

        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    // MARK: - Methods

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
