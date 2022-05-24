//
//  ReceiveAmountViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class ReceiveAmountViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var QRCodeImgView: UIImageView!
    @IBOutlet weak var walletAddressBtn: UIButton!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup
        
        self.intialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.largeTitleDisplayMode = .never

//        self.navigationItem.titleView = setTitle(title: "Username", subtitle: "status")
        
//        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.setSmallHeaderAndHideLargeHeader(header: "Receive")

    }
    
    // MARK: - Methods
    
    func intialSetup(){
        
        // Show Wallet details on screen
        guard  let userInfoDict = userDefault.value(forKey: USER_DEFAULT_userInfo_Key) as? [String: Any] else {
            return
        }
        
        if let userWalletAddress = userInfoDict[USER_DEFAULT_walletAddress_Key] as? String{
            print("userWalletAddress....", userWalletAddress)
            
            self.walletAddressBtn.setTitle(userWalletAddress, for: .normal)
            
            // create QR code and disple on screen
            let image = CommonFxns.generateQRCode(from: userWalletAddress)
            self.QRCodeImgView.image = image
        }
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func copyBtnAction(_ sender: Any) {
        
        

    }
    

}
