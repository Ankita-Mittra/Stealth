//
//  SubscriptionDetailsViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 25/03/2022.
//

import UIKit

class SubscriptionDetailsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSmallHeaderAndHideLargeHeader(header: "Subscription")

        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    // MARK: - Button Actions
    
    @IBAction func nextBtnAction(_ sender: Any) {
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.subscribe.rawValue, bundle: nil)
        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.subscribeNow.rawValue) as? SubscribeNowViewController
        self.navigationController?.pushViewController(otherController!, animated: true)
    }
    

}
