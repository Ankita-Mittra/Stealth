//
//  ContactsRequestListTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class ContactsRequestListTableViewCell: UITableViewCell { // UITableViewHeaderFooterView

    // MARK: - Outlets & Properties

    static let identifier = "ContactsRequestListTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ContactsRequestListTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var titleLbl: UILabelCustomClass!
    @IBOutlet weak var titleImgView: UIImageViewCustomClass!
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
