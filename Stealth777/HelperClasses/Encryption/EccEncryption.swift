//
//  EccEncryption.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 28/03/2022.
//

import Foundation
import SwiftECC
import CryptoKit

class EccEncryption{
    
    // Method to generate keys with ECC encryption using SwiftECC libarry
    func generateEccKeys()-> (privateKey: String, publicKey: String){
    
        // Creating private and Publkic keys using ECC
        let domain = Domain.instance(curve: .EC256r1)
        let (publicKey, privateKey) = domain.makeKeyPair()
        
        var pbKey = publicKey.pem.deletingPrefix(EncryptionKeys.publicPrefix.rawValue)
        pbKey = pbKey.deletingSuffix(EncryptionKeys.publicSuffix.rawValue)

        return (privateKey.pem, pbKey)
    }

    func swiftyECC() {
        do {
            let domain = Domain.instance(curve: .EC256r1)

    //             // Party A's keys
            let (public_ios, private_ios) = domain.makeKeyPair()

            let priv_ios_str = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIOfZ40GOHGmWawm4Oc3eHY5k3qRrkeMfrQHQ97BiNl8CoAoGCCqGSM49\nAwEHoUQDQgAEfMH8q+EeTaadxJze+VoN8ik1b/eAAlykEVbFykPrY1x+/G0Vr6/I\nYhQbK74RpG6x9gnJKBUG4+/fJRBANNjDcQ==\n-----END EC PRIVATE KEY-----"
            let priv_iOS = try ECPrivateKey(pem: priv_ios_str)
            print("exported priv_ios...", priv_iOS.pem)
            
            let pub_iOS_str = "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEfMH8q+EeTaadxJze+VoN8ik1b/eA\nAlykEVbFykPrY1x+/G0Vr6/IYhQbK74RpG6x9gnJKBUG4+/fJRBANNjDcQ==\n-----END PUBLIC KEY-----"
            let pub_iOS = try ECPublicKey(pem: pub_iOS_str)
            print("exported pub_iOS...", pub_iOS.pem)

            // Party B's keys

            let private_android  = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIP3IeHUUAZFynG7qoZFiqX6OP/r7myLUhrE6GCc1aZEaoAoGCCqGSM49\nAwEHoUQDQgAEgTRYk9G849srpu1HE7SnM9MbP/YCkzizbp4GJmyNEV56q5uRaJMN\nTuKAVxFhCYW0ZWMt5Ju0D1svy7u7cMAUrA==\n-----END EC PRIVATE KEY-----"
    //            let pub_Android = "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEgTRYk9G849srpu1HE7SnM9MbP/YC\nkzizbp4GJmyNEV56q5uRaJMNTuKAVxFhCYW0ZWMt5Ju0D1svy7u7cMAUrA==\n-----END PUBLIC KEY-----"
            let pub_Android = "-----BEGIN PUBLIC KEY-----\nMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEtmO1qMu2hdpYz2b9u5TUrDa+UEoEGtk9/sth+P4L\nVnQ2221D8jrHK2wNbTcvYGnZo6KhiEIPhFNGDsABkl8IGQ==\n-----END PUBLIC KEY-----"

            let pubKeyAndroid = try ECPublicKey(pem: pub_Android)

            let priKeyAndroid = try ECPrivateKey(pem: private_android)
            
            print("exported Pem...", pubKeyAndroid.pem)
            print("exported Pem...", priKeyAndroid.pem)


            let importPrivateKey_android = try self.importPrivateKey(priKeyAndroid.pem)
            let importPublickey_android = try self.importPublicKey(pubKeyAndroid.pem)
            let importPrivateKey_ios = try self.importPrivateKey(priv_iOS.pem)
            let importPublickey_ios = try self.importPublicKey(pub_iOS.pem)

            print("importPublickey : ", importPublickey_android.pemRepresentation)
            print("importPublickey ios : ", importPublickey_android.pemRepresentation)

            let info: Bytes = [1,2,3]
            let secretA = try private_ios.keyAgreement(pubKey: pubKeyAndroid, length: 8, md: .SHA2_256, sharedInfo: info)
            print("secret A....", secretA.description.toBase64())
            
            let deriveKey = try self.deriveSymmetricKey(privateKey: importPrivateKey_ios, publicKey: importPublickey_android)
            print("deriveKey...", deriveKey)
            let sensitiveMessage = "HI,Shafat".data(using: .utf8)!

            let iv = CryptoKit.AES.GCM.Nonce()
            
            let sealedBox = try! CryptoKit.AES.GCM.seal(sensitiveMessage,
                                              using: deriveKey,
                                              nonce: iv)
            let cipher = sealedBox.ciphertext + sealedBox.tag
            print("cipher.....", cipher.base64EncodedString() )

            let symmetricKey = try deriveSymmetricKey(privateKey: importPrivateKey_ios, publicKey: importPublickey_android)

            let sensitiveMessageAndroid = "HLlYDHImPGQi6sle96F2VOjuMgjmVLgXLrnieXo87XA=".data(using: .utf8)!
            let nonce = "O5ZPMUTqHOEXepSZ".data(using: .utf8)
            // need to prefix data with nonce, because data from kotlin/java contains the cipher text plus the tag at the end.
            // we want nonce || ciphertext || tag for CryptoKit to be happy
            let combine = nonce! + sensitiveMessageAndroid
            let myNewSealedBox = try CryptoKit.AES.GCM.SealedBox(combined: combine)
            
            let res = try CryptoKit.AES.GCM.open(myNewSealedBox, using: symmetricKey)
            let myText = try String(decoding: res, as: UTF8.self)
            print("myText...", myText)
        } catch {
            print("Exception: \(error)")
        }
    }

    func generatePrivateKey() -> P256.KeyAgreement.PrivateKey {
        let privateKey = CryptoKit.P256.KeyAgreement.PrivateKey()
        return privateKey
    }
    
    func exportPrivateKey(_ privateKey: P256.KeyAgreement.PrivateKey) -> String {
        
        let rawPrivateKey = privateKey.pemRepresentation
        return  rawPrivateKey // percentEncodedPrivateKey
    }

    func importPrivateKey(_ privateKey: String) throws -> P256.KeyAgreement.PrivateKey {
        return try CryptoKit.P256.KeyAgreement.PrivateKey(pemRepresentation: privateKey)
    }
    
    func exportPublicKey(_ publicKey: P256.KeyAgreement.PublicKey) -> String {
        let rawPublicKey = publicKey.pemRepresentation
        return rawPublicKey
    }
    
    func importPublicKey(_ publicKey: String) throws -> P256.KeyAgreement.PublicKey {
        return try CryptoKit.P256.KeyAgreement.PublicKey(pemRepresentation: publicKey)
    }
    
    func deriveSymmetricKey(privateKey: P256.KeyAgreement.PrivateKey, publicKey: P256.KeyAgreement.PublicKey) throws -> SymmetricKey {
        let sharedSecret = try privateKey.sharedSecretFromKeyAgreement(with: publicKey)
        print("sharedSecret hex format", sharedSecret)

        let base64 = sharedSecret.withUnsafeBytes { Data(Array($0)).base64EncodedString() }
        print("sharedSecretee:\n\(base64)\n")

        let symmetricKey = sharedSecret.hkdfDerivedSymmetricKey(
            using: SHA256.self ,
            salt: "1234567812345678".data(using: .utf8)!,
            sharedInfo: Data(),
            outputByteCount: 32
        )
        print("symmetricKey....", symmetricKey.withUnsafeBytes { Data(Array($0)).base64EncodedString() })
        return symmetricKey
    }
}

// Method to save ECC private and public key locally

//    func abc(){
//
//        let newOtherUserPublicKey = "-----BEGIN PUBLIC KEY-----\n" + publickey + "\n-----END PUBLIC KEY-----"
//        var encryptedText =  String()
//
//        do {
//            let importOtherUserPublicKey = try self.importPublicKey(newOtherUserPublicKey)
//            let importLoggedInUserPrivateKey = try self.importPrivateKey(privateKey)
//
//            let deriveKey = try self.deriveSymmetricKey(privateKey: importLoggedInUserPrivateKey, publicKey: importOtherUserPublicKey)
//            print("deriveKey...", deriveKey)
//            let sensitiveMessage = msg.data(using: .utf8)!
//
//            let iv = CryptoKit.AES.GCM.Nonce()
//
//            let sealedBox = try! CryptoKit.AES.GCM.seal(sensitiveMessage,
//                                              using: deriveKey,
//                                              nonce: iv)
//            let cipher = sealedBox.ciphertext + sealedBox.tag
//            encryptedText = cipher.base64EncodedString()
//            print("encryptedText.....", encryptedText )
//
//        }
//
//
//        catch let error{
//            print("error...", error.localizedDescription)
//        }
//        // generate shared key
//
//    }
//     func exportPublicKeyInValidFormat(msg: String, publickey: String, privateKey: String)-> String{
//
//        let newOtherUserPublicKey = "-----BEGIN PUBLIC KEY-----\n" + publickey + "\n-----END PUBLIC KEY-----"
//        var encryptedText =  String()
//
//        do {
//            let otherUserPbkey = try ECPublicKey(pem: newOtherUserPublicKey)
//
//            let loggedInUserPrKey = try ECPrivateKey(pem: privateKey)
//
//            print("otherUserPbkey..", otherUserPbkey)
//            print("loggedInUserPrKey..", loggedInUserPrKey)
//
//            let importOtherUserPublicKey = try self.importPublicKey(otherUserPbkey.pem)
//            let importLoggedInUserPrivateKey = try self.importPrivateKey(loggedInUserPrKey.pem)
//
//            let deriveKey = try self.deriveSymmetricKey(privateKey: importLoggedInUserPrivateKey, publicKey: importOtherUserPublicKey)
//            print("deriveKey...", deriveKey)
//            let sensitiveMessage = msg.data(using: .utf8)!
//
//            let iv = CryptoKit.AES.GCM.Nonce()
//
//            let sealedBox = try! CryptoKit.AES.GCM.seal(sensitiveMessage,
//                                              using: deriveKey,
//                                              nonce: iv)
//            let cipher = sealedBox.ciphertext + sealedBox.tag
//            encryptedText = cipher.base64EncodedString()
//            print("encryptedText.....", encryptedText )
//
//        }
//         catch{
//         }
//         return encryptedText
//     }
//
//    func encryptTextMsg(msg:String){
//
//
//
//    }
//
