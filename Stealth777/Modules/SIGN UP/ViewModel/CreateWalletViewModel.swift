//
//  CreateWalletViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class CreateWalletViewModel {
    
    // MARK: - Properties
    
    private var signUpResponse: SignUpResponse? {
        didSet {
            guard let s = signUpResponse else { return }
            self.storeUserDataLocally(with: s)
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
    var walletAddress = String()
    private var apiService: SignUpAPIService?
    
    var userDetailsDict = [String: Any] ()
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.

    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    
    init(apiService: SignUpAPIService) {
        self.apiService = apiService
    }
    
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
        self.publickey = self.getPublicKey()

        signUpDict[enumAPIKeysForUser.userType_key.rawValue] = userType
        signUpDict[enumAPIKeysForUser.platform_key.rawValue] = platform
        signUpDict[enumAPIKeysForUser.deviceNo_key.rawValue] = device.uuid
        signUpDict[enumAPIKeysForUser.deviceName_key.rawValue] = device.name
        signUpDict[enumAPIKeysForUser.deviceVersion_key.rawValue] = device.version
        signUpDict[enumAPIKeysForUser.publicKey_key.rawValue] = publickey
        signUpDict[enumAPIKeysForUser.mediaId_key.rawValue] = emptyStr
        signUpDict[enumAPIKeysForUser.bio_key.rawValue] = emptyStr
        
        print("sign Up DIct ....", signUpDict)
        
        self.userDetailsDict = signUpDict
        
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
    
    
    // MARK: - UI Logic
    
    private func storeUserDataLocally(with signUpResponse: SignUpResponse) {
                    
        let userDetails =  UserModel(userId:signUpResponse.userId, username: self.userDetailsDict[enumAPIKeysForUser.username_key.rawValue] as! String, userType: self.userDetailsDict[enumAPIKeysForUser.userType_key.rawValue] as! Int, bio: self.userDetailsDict[enumAPIKeysForUser.bio_key.rawValue] as! String, imageUrl: self.userDetailsDict[enumAPIKeysForUser.mediaId_key.rawValue] as! String, isMute: zero, isBlock: zero, isPin: zero, allowWipeout: zero, onlineStatus: zero, lastOnlineTime: emptyStr, walletKey: self.userDetailsDict[enumAPIKeysForUser.walletId_key.rawValue] as! String, relation: zero, publicKey: self.userDetailsDict[enumAPIKeysForUser.publicKey_key.rawValue] as! String, accountStatus: zero).toAnyObject()
        // save data locally
        
        
        
        print("userdetails dict...", userDetails)
        
        UserDefaultsToStoreUserInfo.saveUserDataInUserDefaults(token: signUpResponse.token, userId: signUpResponse.userId, publicKey: self.publickey, privateKey: self.privateKey, walletAddress: self.walletAddress, userDetails: userDetails as! [String : Any])
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

