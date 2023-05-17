//
//  GroupChatHeaderView.swift
//  Stealth777
//
//  Created by Manpreet Singh on 21/07/2022.
//

import Foundation
import UIKit
class GroupChatHeaderView:UIView{
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var lblGroupName:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var imgPhoto:UIImageView!
    @IBOutlet var contentView: UIView!
    
    // MARK: - Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView(){
        self.backgroundColor = .clear
        Bundle.main.loadNibNamed("GroupChatHeaderView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
    }
    
}

