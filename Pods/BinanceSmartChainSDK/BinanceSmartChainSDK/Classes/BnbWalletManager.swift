//
//  BnbWalletManager.swift
//  BinanceSmartChainSDK
//
//  Created by CenterPrime on 2021/01/17.
//

import Foundation
import web3swift
import SwiftyJSON
import Alamofire
import BigInt

public final class BnbWalletManager {

    var infuraUrl = "";
    var web3Manager:  web3

    
//    const val BINANCE_MAIN_NET = "https://bsc-dataseed1.binance.org:443"
//    const val ETHEREUM_MAIN_NET = "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689"
    
    
    var importedWalletAddress = String()
    
    public init(infuraUrl : String) {
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
        self.infuraUrl = infuraUrl;
        self.web3Manager = web3(provider: Web3HttpProvider(URL(string: infuraUrl)!)!)
        self.web3Manager.addKeystoreManager(keystoreManager)
    }

    /* Wallet Create */ // CHANGED
    public func createWallet(walletPhrase : String) throws -> Wallet? {
        

        var mapToUpload = [String: Any]()
        mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
        mapToUpload["action_type"] = "WALLET_CREATE"
        do {
            let wallet = try BIP32Keystore(mnemonics: walletPhrase)
            
            let walletAddress = "\(wallet?.addresses?.first?.address ?? "0x")"
            print("createWallet walletAddress...", wallet?.addresses as Any)
            
            self.importedWalletAddress = walletAddress
            print("walletAddress....", walletAddress)
            
//            let ks = try EthereumKeystoreV3(password : "stealth777", aesMode: "aes-128-ctr")
            // encode json
            let jsonEncoder = JSONEncoder()
            let keydata = try jsonEncoder.encode(wallet?.keystoreParams)
            let keystore = String(data: keydata, encoding: String.Encoding.utf8)

            print("keystore phrase..", keystore)
//            let binance = BnbWalletManager.init(infuraUrl: "https://mainnet.infura.io/v3/a396c3461ac048a59f389c7778f06689")//"https://bsc-dataseed1.binance.org:443")
//            let abc = try binance.exportPrivateKey(walletAddress: walletAddress, password: "")
//            print("abc....", abc)
            
            writeToFile(fileName: walletAddress, keystore: keydata)

            mapToUpload["wallet_address"] = walletAddress
            mapToUpload["status"] = "SUCCESS"
            self.sendToHyperLedger(map: mapToUpload)
            
            return Wallet(keystore: keystore!, walletAddress: walletAddress)
        } catch {
              mapToUpload["status"] = "FAILURE"
              print(error.localizedDescription);
              self.sendToHyperLedger(map: mapToUpload)
              throw error
        }
    }
    
//    func send(){
//        self.testing()
//
//    }
    
    
    func getTransactionHisrtory(){
        
        print("getTransactionHisrtory")
        let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")

        
        
        do{
            let txs = try web3Manager.txPool.getStatus()
            
            
            let result = try web3Manager.eth.getTransactionDetails(self.trans.debugDescription.data(using: .utf8)!)
            print("resuklt....", result)
            
//            let txs = try binance.web3Manager.eth.
            print("txs", txs)
            
            
        }catch{
            print("txs")
        }

//        web3Manager.eth.callPromise(, transactionOptions: .defaultOptions)
        
        // txs TxPoolStatus(pending: 14, queued: 158)
//        txs TxPoolStatus(pending: 17, queued: 150)
        
//        txs TxPoolStatus(pending: 16, queued: 157)
        
//        txs TxPoolStatus(pending: 14, queued: 157)
//        txs TxPoolStatus(pending: 33,  queued: 30)
//        txs TxPoolStatus(pending: 17, queued: 112)
        
//        txs TxPoolStatus(pending: 34, queued: 48)



    }
    
    // Wallet Create
    public func createWallet(walletPassword : String) throws -> Wallet? {
        var mapToUpload = [String: Any]()
        mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
        mapToUpload["action_type"] = "WALLET_CREATE"
        
          do {
                let ks = try EthereumKeystoreV3(password : walletPassword, aesMode: "aes-128-ctr")
                // encode json
    
            let jsonEncoder = JSONEncoder()
                let keydata = try jsonEncoder.encode(ks!.keystoreParams)
                let walletAddress = ks?.addresses?.first

                print("walletAddress created by password...", walletAddress)
            
                let keystore = String(data: keydata, encoding: String.Encoding.utf8)

                print("keystore..", keystore)

                writeToFile(fileName: walletAddress!.address, keystore: keydata)

                mapToUpload["wallet_address"] = walletAddress?.address
                mapToUpload["status"] = "SUCCESS"
                self.sendToHyperLedger(map: mapToUpload)

            return Wallet(keystore: keystore!, walletAddress: walletAddress!.address)
        } catch {
              mapToUpload["status"] = "FAILURE"
              print(error.localizedDescription);
              self.sendToHyperLedger(map: mapToUpload)
              throw error
        }
    }
    
    public func sendBNBTesting(walletAddress: String){

        print("testing....")
        let tokenAmount = "0.005"
        
        let gasPrice = BigUInt(0.005)
        let gasLimit = 0.1
        
//        let walletAddress = "0x6c1569B244ABDF8b3902467c300B7C22DB58c019"//0x113484312f8a6c4f98a2b5e3621316535ac13291"//
        let receiverAddress = "0x4b8dbF6Fa6777F4bdE11a3d0A652843FE82fbF32"//"0x38acEd2Bb72A75a3cfBB5eA82D73aa737754cfeF"
        
//        print("self.importedWalletAddress....", self.importedWalletAddress)
//        let tokenContractAddress = "0xe142480898845f5270ee4A47Ad8D479bd37e6A3B"
        do {
            let binance = BnbWalletManager.init(infuraUrl: "https://bsc-dataseed1.binance.org:443")
            
            let balance = try binance.getBnbBalance(walletAddress: walletAddress)
            
            print("balance.....", balance)
//            let result = try binance.sendBEP20Token(walletAddress: walletAddress, password: "", receiverAddress: receiverAddress, tokenAmount: tokenAmount, tokenContractAddress: tokenContractAddress, gasPrice: BigUInt(gasPrice), gasLimit: BigUInt(gasLimit))
            
            let result = try binance.sendBnb(walletAddress: walletAddress, password: "", receiverAddress: receiverAddress, etherAmount: tokenAmount, gasPrice: BigUInt(0.005), gasLimit: BigUInt(0.1))
            
//            let result1 = try binance.sendBEP20Token(walletAddress: walletAddress, password: "123456", receiverAddress: receiverAddress, tokenAmount: tokenAmount, tokenContractAddress: tokenContractAddress, gasPrice: 0, gasLimit: 0)
            
//            let result = try self.sendBEP20Token(walletAddress: walletAddress, password: "", receiverAddress: receiverAddress, tokenAmount: tokenAmount, tokenContractAddress: tokenContractAddress, gasPrice: BigUInt(gasPrice), gasLimit: BigUInt(gasLimit))
            
            print("result....", result)
//            print("result1....", result1)
        }
        catch let error {
            print("sendToeknError...", error)
        }
    }
    
    /* Import Wallet By Keystore */
    public func importByKeystore(keystore : String , password : String) throws -> Wallet? {
        var mapToUpload = [String: Any]()
        mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
        mapToUpload["action_type"] = "WALLET_IMPORT_KEYSTORE"
        do {
            let decoder = JSONDecoder()
            let json = JSON.init(parseJSON:keystore)
            let keystoreData: Data =  try JSONEncoder().encode(json)// Load keystore data from file?
            let keystore1 = try decoder.decode(Keystore.self, from: keystoreData)
            _ = try keystore1.privateKey(password: password)
            let walletAddress = keystore1.address
            
            writeToFile(fileName: walletAddress, keystore: keystoreData)

            mapToUpload["wallet_address"] = walletAddress
            mapToUpload["status"] = "SUCCESS"
            self.sendToHyperLedger(map: mapToUpload)
            return Wallet(keystore: keystore, walletAddress: walletAddress)
        } catch {
            print(error.localizedDescription)
            mapToUpload["status"] = "FAILURE"
            self.sendToHyperLedger(map: mapToUpload)
            throw error
        }
    }
    
    /* Import Wallet By Private Key */
    public func importByPrivateKey(privateKey : String ) throws -> Wallet? {
        var mapToUpload = [String: Any]()
        mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
        mapToUpload["action_type"] = "WALLET_IMPORT_PRIVATE_KEY"
        do {
            let privateKeyData = Data.fromHex(privateKey)
            let password = ""
            let ks = try EthereumKeystoreV3(privateKey: privateKeyData!, password: password ,aesMode: "aes-128-ctr")
            let jsonEncoder = JSONEncoder()
            let keydata = try jsonEncoder.encode(ks?.keystoreParams)
            
            let walletAddress = ks?.addresses?.first
            
            let keystore = String(data: keydata, encoding: String.Encoding.utf8)
            
            writeToFile(fileName: walletAddress!.address, keystore: keydata)

            mapToUpload["wallet_address"] = walletAddress?.address
            mapToUpload["status"] = "SUCCESS"
            self.sendToHyperLedger(map: mapToUpload)
            return Wallet(keystore: keystore, walletAddress: walletAddress?.address)
        } catch {
            print(error.localizedDescription)
            mapToUpload["status"] = "FAILURE"
            self.sendToHyperLedger(map: mapToUpload)
            throw error
        }
    }
    
    
    /* Export Private Key */
    public func exportPrivateKey(walletAddress : String, password : String ) throws -> [UInt8] {
        var mapToUpload = [String: Any]()
        mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
        mapToUpload["action_type"] = "WALLET_EXPORT_PRIVATE_KEY"
        do {
            let decoder = JSONDecoder()
            let keystore = try getKeystore(walletAddress: walletAddress)
            let json = JSON.init(parseJSON:keystore)
            let keystoreData: Data =  try JSONEncoder().encode(json)// Load keystore data from file?
            let keystore1 = try decoder.decode(Keystore.self, from: keystoreData)
            let privateKey = try keystore1.privateKey(password: password)
            mapToUpload["wallet_address"] = walletAddress
            mapToUpload["status"] = "SUCCESS"
            self.sendToHyperLedger(map: mapToUpload)
            return privateKey
        } catch {
            print(error.localizedDescription)
            mapToUpload["wallet_address"] = walletAddress
            mapToUpload["status"] = "FAILURE"
            self.sendToHyperLedger(map: mapToUpload)
            throw error
        }
    }
    
    func getKeystore(walletAddress : String ) throws -> String{
        do {
            let ks = findKeystoreMangerByAddress(walletAddress: walletAddress)
            let jsonEncoder = JSONEncoder()
            let keydata = try jsonEncoder.encode(ks?.keystoreParams)
            let keystore = String(data: keydata, encoding: String.Encoding.utf8)
            return keystore!
        } catch {
            throw error
        }
    }
    
    /* Export Keystore */
    public func exportKeystore(walletAddress : String ) throws -> String {
        var mapToUpload = [String: Any]()
        mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
        mapToUpload["action_type"] = "WALLET_EXPORT_KEYSTORE"
        do {
            let ks = findKeystoreMangerByAddress(walletAddress: walletAddress)
            let jsonEncoder = JSONEncoder()
            let keydata = try jsonEncoder.encode(ks?.keystoreParams)
            let keystore = String(data: keydata, encoding: String.Encoding.utf8)
            mapToUpload["wallet_address"] = walletAddress
            mapToUpload["status"] = "SUCCESS"
            self.sendToHyperLedger(map: mapToUpload)
            return keystore!
        } catch {
            mapToUpload["wallet_address"] = walletAddress
            mapToUpload["status"] = "FAILURE"
            self.sendToHyperLedger(map: mapToUpload)
            throw error
        }
    }
    
    /* Get Bnb Balance */
    public func getBnbBalance (walletAddress : String ) throws -> String? {
        do {
            var mapToUpload = [String: Any]()
            mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
            mapToUpload["action_type"] = "COIN_BALANCE"
            let etherAddress = EthereumAddress(walletAddress)
            let balancebigint = try self.web3Manager.eth.getBalance(address: etherAddress!)
            let etherBalance  = (String(describing: Web3.Utils.formatToEthereumUnits(balancebigint )!))
            print(etherBalance)
            mapToUpload["wallet_address"] = etherAddress?.address
            mapToUpload["status"] = "SUCCESS"
            mapToUpload["balance"] = etherBalance
            self.sendToHyperLedger(map: mapToUpload)
            return etherBalance
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    /* Get BEP20 Token Balance */
    public func getBEP20TokenBalance (tokenContractAddress : String , walletAddress : String ) throws -> String? {
        do {
            let contractAddress = EthereumAddress(tokenContractAddress)
            let contract = self.web3Manager.contract(Web3Utils.erc20ABI, at: contractAddress, abiVersion: 2)!
            let tokenName = try contract.method("name")?.call()
            let tokenSymbol = try contract.method("symbol")?.call()
            let decimals = try contract.method("decimals")?.call()
            let balance = try contract.method("balanceOf", parameters: [walletAddress] as [AnyObject], extraData: Data(), transactionOptions: TransactionOptions.defaultOptions)?.call()
            // balanceOf
            let numStr = decimals!["0"] as! BigUInt
            let decimal = Double(String(numStr))

            let balanceStr = balance!["0"] as! BigUInt
            let tokenBalance = Double(String(balanceStr))
            let tokenBal = tokenBalance!/pow(10, decimal!)

            var mapToUpload = [String: Any]()
            mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
            mapToUpload["action_type"] = "TOKEN_BALANCE"
            mapToUpload["wallet_address"] = walletAddress
            mapToUpload["token_smart_contract"] = tokenContractAddress
            mapToUpload["token_name"] = tokenName!["0"]!
            mapToUpload["token_symbol"] = tokenSymbol!["0"]!
            mapToUpload["balance"] = tokenBal
            mapToUpload["status"] = "SUCCESS"
            
            self.sendToHyperLedger(map: mapToUpload)
            
            return String(tokenBal)
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    /* Get BEP20 Token Balance */
    public func importBEP20TokenAndGetBalance(tokenContractAddress : String , walletAddress : String ) throws -> [String: Any]? {
        do {
            let contractAddress = EthereumAddress(tokenContractAddress)
            let contract = self.web3Manager.contract(Web3Utils.erc20ABI, at: contractAddress, abiVersion: 2)!
            let tokenName = try contract.method("name")?.call()
            let tokenSymbol = try contract.method("symbol")?.call()
            let decimals = try contract.method("decimals")?.call()
            let balance = try contract.method("balanceOf", parameters: [walletAddress] as [AnyObject], extraData: Data(), transactionOptions: TransactionOptions.defaultOptions)?.call()
            // balanceOf

            var dict = [String: Any]()
            
            if decimals != nil {
                let numStr = decimals?["0"] as! BigUInt
                let decimal = Double(String(numStr))

                let balanceStr = balance!["0"] as! BigUInt
                let tokenBalance = Double(String(balanceStr))
                let tokenBal = tokenBalance!/pow(10, decimal!)
                
                dict = ["tokenName" : tokenName as Any,"tokenSymbol": tokenSymbol, "decimals": decimals, "balance": tokenBal] as? [String: Any] ?? [:]
            }
            return dict
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    
    /* Send BEP20 Token */
    public func sendBEP20Token(walletAddress : String , password : String , receiverAddress : String , tokenAmount : String, tokenContractAddress : String,
                               gasPrice : BigUInt , gasLimit : BigUInt) throws -> String? {
        
        do {

            if (findKeystoreMangerByAddress(walletAddress: walletAddress) == nil) {
                return "Keystore does not exist"
            }
            let contractAddress =  EthereumAddress(tokenContractAddress)
            let receviverEthAddress =  EthereumAddress(receiverAddress)
            let senderEthAddress = EthereumAddress(walletAddress)
            let contract = self.web3Manager.contract(Web3Utils.erc20ABI, at: contractAddress, abiVersion: 2)!
            let tokenName = try contract.method("name")?.call()
            let tokenSymbol = try contract.method("symbol")?.call()
            let amount = Web3.Utils.parseToBigUInt(tokenAmount, units: .eth)

            var options = TransactionOptions.defaultOptions
            
            options.from = senderEthAddress
            let gweiUnit = BigUInt(1000000000)
            options.gasPrice = .manual(gasPrice * gweiUnit)
            options.gasLimit = .manual(gasLimit)
            
            let contratInstance = try contract.method("transfer", parameters: [receviverEthAddress, amount ?? 0] as [AnyObject], extraData: Data(), transactionOptions: options)?.send(password: password, transactionOptions: options)
            
            let transaction = contratInstance?.hash
            
            var mapToUpload = [String: Any]()
            mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
            mapToUpload["action_type"] = "SEND_TOKEN"
            mapToUpload["from_wallet_address"] = walletAddress
            mapToUpload["to_wallet_address"] = receiverAddress
            mapToUpload["amount"] = tokenAmount
            mapToUpload["gasLimit"] = String(gasLimit)
            mapToUpload["gasPrice"] = String(gasPrice)
            mapToUpload["fee"] = Web3.Utils.formatToEthereumUnits(gasPrice * gasLimit, toUnits: .Gwei, decimals: 8, decimalSeparator: ".")
            mapToUpload["token_smart_contract"] = tokenContractAddress
            mapToUpload["token_name"] = tokenName!["0"]!
            mapToUpload["token_symbol"] = tokenSymbol!["0"]!
            mapToUpload["tx_hash"] = transaction
            mapToUpload["status"] = "SUCCESS"
            
            self.sendToHyperLedger(map: mapToUpload)

            return transaction
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    
    var trans : Any!
    /* Send BNB  */
    public func sendBnb(walletAddress : String , password : String , receiverAddress : String , etherAmount : String ,
    gasPrice : BigUInt , gasLimit : BigUInt) throws -> String? {
        
        do {
//            let keystoreManager = findKeystoreMangerByAddress(walletAddress: walletAddress)
//            if (keystoreManager == nil) {
//                return "Keystore does not exist"
//            }
//
//            print("gas price, limi..., wallet address ", gasPrice, gasLimit, walletAddress)

            let ethSenderAddress = EthereumAddress(walletAddress)!
            let resEthAddress = EthereumAddress(receiverAddress)!
            let contract = self.web3Manager.contract(Web3.Utils.coldWalletABI, at: resEthAddress, abiVersion: 2)!
            let amount = Web3.Utils.parseToBigUInt(etherAmount, units: .eth)
            var options = TransactionOptions.defaultOptions
            options.value = amount
            options.from = ethSenderAddress
            
            print("sender....", options.from)
            let gweiUnit = BigUInt(1000000000)
            print(gweiUnit)
            
            
            print("sender....", ethSenderAddress)
            options.gasPrice = .automatic//.manual(gasPrice * gweiUnit)
            options.gasLimit = .automatic//.manual(gasLimit)

            let tx = contract.write(
                                "fallback",
                                parameters: [AnyObject](),
                                extraData: Data(),
                                transactionOptions: options)!
            print("tx....", tx)
            trans = tx
            
            self.getTransactionHisrtory()
            let result = try tx.send(password: password)

            print("result..", result)
            var mapToUpload = [String: Any]()
            mapToUpload["network"] = isMainnet() ? "MAINNET" : "TESTNET"
            mapToUpload["action_type"] = "SEND_BNB"
            mapToUpload["from_wallet_address"] = walletAddress
            mapToUpload["to_wallet_address"] = receiverAddress
            mapToUpload["amount"] = etherAmount
            mapToUpload["gasLimit"] = String(gasLimit)
            mapToUpload["gasPrice"] = String(gasPrice)
            mapToUpload["fee"] = Web3.Utils.formatToEthereumUnits(gasPrice * gasLimit, toUnits: .Gwei, decimals: 8, decimalSeparator: ".")
            mapToUpload["tx_hash"] = result.hash
            mapToUpload["status"] = "SUCCESS"
            
            self.sendToHyperLedger(map: mapToUpload)
            
            return result.hash
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func sendToHyperLedger (map : [String: Any]) {
        
        let url = "http://34.231.96.72:8081/createTransaction/"
        
        var mapToUpload = [String : Any]()
        var body = map
        
        mapToUpload["orgname"] = "org1"
        mapToUpload["username"] = "user1"
        mapToUpload["tx_type"] = "BINANCE"
        if let theJSONData = try?  JSONSerialization.data(
          withJSONObject: self.getDeviceInfo()
          ),
          let theJSONText = String(data: theJSONData,
                                   encoding: String.Encoding(rawValue: String.Encoding.RawValue(Int(String.Encoding.ascii.rawValue)))) {
            body["DEVICE_INFO"] = theJSONText
        }
        mapToUpload["body"] = body
        
        print(mapToUpload)
        Alamofire.request(url, method: .post, parameters: mapToUpload,encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in
        switch response.result {
            case .success:
                print(response)
                break
            
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func isMainnet() -> Bool {
        return self.infuraUrl.contains("https://bsc-dataseed1.binance.org:443")
    }
    
    func getDeviceInfo() -> [String : Any]{
        var data = [String : Any]()
        
        let deviceUUID = UIDevice.current.identifierForVendor!.uuidString
        let osName = "iOS"
        let modelName = UIDevice.current.name
        let serialNumber = "Not allowed"
        let manufacturer = "Apple"
        
        data["ID"] = deviceUUID
        data["OS"] = osName
        data["MODEL"] = modelName
        data["SERAIL"] = serialNumber
        data["MANUFACTURER"] = manufacturer
        return data
    }
    
    func writeToFile(fileName : String , keystore : Data){
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        FileManager.default.createFile(atPath: userDir + "/keystore/" + fileName.lowercased() +  ".json", contents: keystore, attributes: nil)
        
        print("writeToFile...")
        
    }
    
    
    func findKeystoreMangerByAddress(walletAddress : String) -> BIP32Keystore?{//EthereumKeystoreV3? {
        let ethWalletAddress = EthereumAddress(walletAddress)
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
        
        let bipKeystore = keystoreManager?.bip32keystores
        
        print(bipKeystore)
        print(bipKeystore?.count)
        let bip = BIP32Keystore(walletAddress)
        for i in keystoreManager?.bip32keystores ?? [] {
            
           
            print("keystore iii...",  i.addresses?.first?.address.lowercased())// i.getAddress()?.address.lowercased())
            print("keystore eth...", ethWalletAddress?.address.lowercased())

            if (i.addresses?.debugDescription == walletAddress ){//ethWalletAddress?.address.lowercased()){
                return i
            }
        }
        return bip
    }
    
    
//    func findKeystoreMangerByAddress(walletAddress : String) -> EthereumKeystoreV3? {
//        let ethWalletAddress = EthereumAddress(walletAddress)
//        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
//        for i in keystoreManager?.keystores ?? [] {
//
//            print("keystore iii...", i.getAddress()?.address.lowercased())
//            print("keystore eth...", ethWalletAddress?.address.lowercased())
//
//            if (i.getAddress()?.address.lowercased() == ethWalletAddress?.address.lowercased()){
//                return i
//            }
//        }
//        return nil
//    }
//
}
