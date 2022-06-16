//
//  GroupControlsListTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 25/03/2022.
//

import UIKit

class GroupControlsListTableViewCell: UITableViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var titleBtn: UIButton!

    static let identifier = "GroupControlsListTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "GroupControlsListTableViewCell", bundle: nil)
    }
    
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
