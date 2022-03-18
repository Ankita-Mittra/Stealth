//
//  BaseViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 08/03/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        navigationController?.navigationBar.isTranslucent = true
        
//        navigationController?.navigationBar.backgroundColor = UIColor(displayP3Red: 243, green: 243, blue: 243, alpha: 1)
        
//        navigationController?.navigationBar.barTintColor = .
        
        
        //        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        //        navigationController?.navigationItem.leftBarButtonItem?.tintColor = .orange
        //
        //
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
            
    }
    

    func setLargeHeaderOnNavigationBar(largeTitleHeader: String){
        self.title = largeTitleHeader
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func hideBackButton(){
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func hideNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func setSmallHeaderAndHideLargeHeader(header: String){
        self.title = header
        navigationController?.navigationBar.prefersLargeTitles = false

    }
    
    func showNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func hideSearchBar(){
        navigationItem.searchController = nil
    }
    
    func setSearchBarOnNavigationBar(){
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController

    }

}
