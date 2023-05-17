//
//  GroupSettingsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class GroupSettingsTableViewCell: UITableViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var onOffSwitch: UISwitch!
    @IBOutlet weak var forwardIconImgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabelCustomClass!

    static let identifier = "GroupSettingsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "GroupSettingsTableViewCell", bundle: nil)
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
