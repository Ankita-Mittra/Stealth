//
//  SettingsOptionsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class SettingsOptionsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var titleLbl: UILabelCustomClass!
    @IBOutlet weak var permissionSwitch: UISwitch!
    @IBOutlet weak var forwardIconImgView: UIImageView!
    @IBOutlet weak var versionLbl: UILabelCustomClass!
    @IBOutlet weak var languageLbl: UILabelCustomClass!

    static let identifier = "SettingsOptionsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "SettingsOptionsTableViewCell", bundle: nil)
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
