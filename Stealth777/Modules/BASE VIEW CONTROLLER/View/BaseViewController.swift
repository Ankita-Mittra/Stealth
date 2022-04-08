//
//  BaseViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 08/03/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial Setup
        self.initialSetupForEveryViewController()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods for Initial Setup

    // Method for initial Setups
    func initialSetupForEveryViewController(){
        self.lockAppOnDoubleTap() // Lock app
    }
    
    func addKeyboardobserversOnScreen(){
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Keyboard notifications methods
    

    // Method to show keyboard

    @objc func keyboardWillShow(notification: NSNotification) {
            
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    // Method to hide keyboard

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    // MARK: - Methods
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
