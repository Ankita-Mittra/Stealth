//
//  CreateGroupViewController.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/03/2022.
//

import UIKit

class CreateGroupViewController: BaseViewController {
    
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var membersCollectionView: UICollectionView!
//    @IBOutlet weak var copyBtn: UIButton!

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSmallHeaderAndHideLargeHeader(header: "Group Details")
        self.navigationItem.largeTitleDisplayMode = .never
        
        
        let create = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(createGroupBtnAction)) //UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(nextBtnAction))
        
        self.navigationItem.setRightBarButton(create, animated: true)
    }

//    override func viewWillLayoutSubviews() {
//        self.membersCollectionView.reloadData()
//    }

    // MARK: - Button Actions
    
    @objc func createGroupBtnAction() {
        
        let storyBoard = UIStoryboard.init(name: enumStoryBoard.groupChat.rawValue, bundle: nil)
        let objLocationSearch = storyBoard.instantiateViewController(withIdentifier: enumViewControllerIdentifier.groupChat .rawValue) as? GroupChatViewController
        self.navigationController?.pushViewController(objLocationSearch!, animated: true)
    }
}


extension CreateGroupViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        guard let phraseCell = self.membersCollectionView.dequeueReusableCell(withReuseIdentifier: GroupMembersListCollectionViewCell.identifier, for: indexPath) as? GroupMembersListCollectionViewCell else{
            return cell
        }
        return phraseCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 75, height: self.membersCollectionView.frame.height)
    }
    
}



