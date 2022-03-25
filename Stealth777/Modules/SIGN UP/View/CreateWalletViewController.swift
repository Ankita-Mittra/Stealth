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

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
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

    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        
        let navController:UINavigationController = (appDelegate.window?.rootViewController as? UINavigationController)!
        let mainStoryboard: UIStoryboard = UIStoryboard(name: enumStoryBoard.privateTabBarController.rawValue, bundle: nil)
        let loginVcObj = mainStoryboard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.privateModeTabBar .rawValue) as! PrivateModeTabBarViewController
        navController.pushViewController(loginVcObj, animated: true)
    }
    


}


extension CreateWalletViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let phraseCell = self.phraseCollectionView.dequeueReusableCell(withReuseIdentifier: WalletPhraseCollectionViewCell.identifier, for: indexPath) as? WalletPhraseCollectionViewCell else{
            return cell
        }
        phraseCell.titleLbl.text = "\(indexPath.row + 1). Title"
        return phraseCell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print((self.phraseCollectionView.frame.width/2) - 23)
        return CGSize(width: (self.phraseCollectionView.frame.width/2) - 23, height: 45)
    }
}


