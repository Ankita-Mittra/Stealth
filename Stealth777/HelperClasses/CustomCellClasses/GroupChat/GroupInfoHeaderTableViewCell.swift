//
//  GroupInfoHeaderTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 21/03/2022.
//

import UIKit

class GroupInfoHeaderTableViewCell: UITableViewHeaderFooterView {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var groupNameLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    
    static let identifier = "GroupInfoHeaderTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "GroupInfoHeaderTableViewCell", bundle: nil)
    }
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
