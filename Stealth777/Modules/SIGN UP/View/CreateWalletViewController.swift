//
//  CreateWalletViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class CreateWalletViewController: BaseViewController {

    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var phraseCollectionView: UICollectionView!
    @IBOutlet weak var copyBtn: UIButton!
    
    // MARK: - Injection
    
//    let viewModel = PhotoViewModel(dataService: DataService())
    let viewModel = CreateWalletViewModel(apiService: SignUpAPIService())
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerUser(withId: 8)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.largeTitleDisplayMode = .never
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.setSmallHeaderAndHideLargeHeader(header: "Create Account")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillLayoutSubviews() {
        self.phraseCollectionView.reloadData()
    }

    // MARK: - Methods

    // MARK: - Networking
    
    private func registerUser(withId id: Int) {
        viewModel.registerUser()
        
        viewModel.updateLoadingStatus = {
//            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlertClosure = {
            if let error = self.viewModel.error {
                print(error.localizedDescription)
            }
        }
        
        viewModel.didFinishFetch = {
            print("viewmodel...didFinishFetch")
        }
    }
    
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        let navController:UINavigationController = (appDelegate.window?.rootViewController as? UINavigationController)!
        let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.publicModeTabBarController.rawValue, bundle: nil)
        let loginVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.publicModeTabBar .rawValue) as! PublicModeTabBarViewController
        navController.pushViewController(loginVcObj, animated: true)
    }
    


}



