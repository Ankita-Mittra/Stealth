//
//  CreateWalletViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
import UIKit

class CreateWalletViewModel {
    
    // MARK: - Properties
    private var signUpResponse: SignUpResponse? {
        didSet {
            guard let p = signUpResponse else { return }
//            self.setupText(with: p)
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private var apiService: SignUpAPIService?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    
    
    
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: SignUpAPIService) {
        self.apiService = apiService
    }

// MARK: - Network call

func registerUser() {
    
    self.apiService?.signup(parameters: [:], completion: { data, succeeded, error in
        if error != nil{
            self.isLoading = false
            print("error...", error)
        }else{
            print("signUpResponse...", data)
        }
    })
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
        self.copyBtn.isHidden = false
        return phraseCell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print((self.phraseCollectionView.frame.width/2) - 23)
        return CGSize(width: (self.phraseCollectionView.frame.width/2) - 23, height: 45)
    }
}

