//
//  TransactionsHistoryViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class TransactionsHistoryViewController: BaseViewController {

    // MARK: - Properties & Delegates

    @IBOutlet weak var transactionsListTableView: UITableView!
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialUISetup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        

        self.navigationItem.largeTitleDisplayMode = .never

//        self.navigationItem.titleView = setTitle(title: "Username", subtitle: "status")
        
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.setSmallHeaderAndHideLargeHeader(header: "Transactions")

    }
    
    // MARK: - Methods

    func initialUISetup(){
        self.transactionsListTableView.register(TransactionsHistoryTableViewCell.nib(), forCellReuseIdentifier: TransactionsHistoryTableViewCell.identifier)
    }
    
    
    
    // MARK: - Button Actions
    
//    @IBAction func nextBtnAction(_ sender: Any) {
//        
////        let storyBoard = UIStoryboard.init(name: enumStoryBoard.wallet.rawValue, bundle: nil)
////        let otherController = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.sendingAmount.rawValue) as? SendingAmountViewController
////        self.navigationController?.pushViewController(otherController!, animated: true)
//    }

}


extension TransactionsHistoryViewController: UITableViewDelegate, UITableViewDataSource {

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
}

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 68
//    }
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    guard  let tokenCell = self.transactionsListTableView.dequeueReusableCell(withIdentifier: TransactionsHistoryTableViewCell.identifier , for: indexPath) as? TransactionsHistoryTableViewCell else {
        return cell
    }
    
    return tokenCell
}

}

