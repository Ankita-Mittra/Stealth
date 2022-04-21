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
            guard signUpResponse != nil else { return }
            self.didFinishFetch?()
        }
    }
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var privateKey = String()
    var publickey = String()
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

    
    // MARK: - Network call
    
    func registerUser1(dict: [String:Any]) {

        var signUpDict = dict
        
        let device = self.getDeviceInfo()
        let publickey = self.getPublicKey()

        signUpDict[enumAPIKeysForUser.userType_key.rawValue] = userType
        signUpDict[enumAPIKeysForUser.platform_key.rawValue] = platform
        signUpDict[enumAPIKeysForUser.deviceNo_key.rawValue] = device.uuid
        signUpDict[enumAPIKeysForUser.deviceName_key.rawValue] = device.name
        signUpDict[enumAPIKeysForUser.deviceVersion_key.rawValue] = device.version
        signUpDict[enumAPIKeysForUser.publicKey_key.rawValue] = publickey
        signUpDict[enumAPIKeysForUser.mediaId_key.rawValue] = emptyStr
        signUpDict[enumAPIKeysForUser.bio_key.rawValue] = emptyStr
        print("sign Up DIct ....", signUpDict)
//
//        self.apiService?.requestRegister(parameters: signUpDict, completion: { signUpResponse, succeeded, error in
//
//
//            print("elf.apiService?.requestRegister(parameters: signUpDict, completion: { data, succeeded, error in")
//
////            if let error = error {
////                self.error = error
////                self.isLoading = false
////                return
////            }
////            self.error = nil
////            self.isLoading = false
//
////            self.signUpResponse = signUpResponse as SignUpResponse
//
//            print("signUpResponse", signUpResponse)
//
//        })
    }
    
    
    func registerUser(dict: [String:Any]) {
    
        var signUpDict = dict
        
        let device = self.getDeviceInfo()
        let publickey = self.getPublicKey()

        signUpDict[enumAPIKeysForUser.userType_key.rawValue] = userType
        signUpDict[enumAPIKeysForUser.platform_key.rawValue] = platform
        signUpDict[enumAPIKeysForUser.deviceNo_key.rawValue] = device.uuid
        signUpDict[enumAPIKeysForUser.deviceName_key.rawValue] = device.name
        signUpDict[enumAPIKeysForUser.deviceVersion_key.rawValue] = device.version
        signUpDict[enumAPIKeysForUser.publicKey_key.rawValue] = publickey
        signUpDict[enumAPIKeysForUser.mediaId_key.rawValue] = emptyStr
        signUpDict[enumAPIKeysForUser.bio_key.rawValue] = emptyStr
        
        print("sign Up DIct ....", signUpDict)
        
        //        RestApiManager.signup(parameters: signUpDict, completion: { data, succeeded, error in

        self.apiService?.signup(parameters: signUpDict, completion: { data, succeeded, error in
            print("RestApiManager.signup   /.....", signUpDict)
            if succeeded {
                print("succeeded....", succeeded)
                guard let tempData = data else{
                    self.error = error as? Error
                    self.isLoading = false
                    return
                }
                print("tempData....", tempData)
                self.signUpResponse = SignUpResponse(with: tempData["data"] as? [String : AnyObject])
            } else {
                self.error = error as? Error
                self.isLoading = false
               print("error....", error)
            }
        })
  }
    
    
    // MARK: - UI Logic

    // Method to get device basic info like name, uuid, version
    func getDeviceInfo()->(uuid: String, name: String, version: String){
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? emptyStr
        
        let name = UIDevice.current.name
        
        let version = UIDevice.current.systemVersion
        print("uuid...\(uuid)", "name...\(name)", "version...\(version)")

        return (uuid, name, version)
    }
        
    // Method to get public key from generated Key pair
    func getPublicKey()->String{
        let encryption = EccEncryption()
        
        let keyPair = encryption.generateEccKeys()
        self.privateKey = keyPair.privateKey
        
        return keyPair.publicKey
    }

}

extension CreateWalletViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.walletPhraseArr.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let phraseCell = self.phraseCollectionView.dequeueReusableCell(withReuseIdentifier: WalletPhraseCollectionViewCell.identifier, for: indexPath) as? WalletPhraseCollectionViewCell else{
            return cell
        }
        
        phraseCell.titleLbl.text = "\(indexPath.row + 1). \(self.walletPhraseArr[indexPath.row])"
//        self.copyBtn.isHidden = false
        return phraseCell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print((self.phraseCollectionView.frame.width/2) - 23)
        return CGSize(width: (self.phraseCollectionView.frame.width/2) - 23, height: 45)
    }
}

