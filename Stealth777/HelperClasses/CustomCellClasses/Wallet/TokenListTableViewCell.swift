//
//  TokenListTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 15/03/2022.
//

import UIKit

class TokenListTableViewCell: UITableViewCell {

    // MARK: - Outlets & Properties

    @IBOutlet weak var titleImgView: UIImageViewCustomClass!
    @IBOutlet weak var titleLbl: UILabelCustomClass!
    @IBOutlet weak var cellSelectedBtn: UIButton!
    @IBOutlet weak var balanceLbl: UILabelCustomClass!

    static let identifier = "TokenListTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "TokenListTableViewCell", bundle: nil)
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
