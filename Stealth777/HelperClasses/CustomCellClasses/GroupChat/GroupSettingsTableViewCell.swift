//
//  GroupSettingsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class GroupSettingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var onOffSwitch: UISwitch!
    @IBOutlet weak var forwardIconImgView: UIImageView!
    static let identifier = "GroupSettingsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "GroupSettingsTableViewCell", bundle: nil)
    }
    
    @IBAction func onOffSwitch(_ sender: Any) {
    }
    @IBOutlet weak var titleLbl: UILabelCustomClass!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
