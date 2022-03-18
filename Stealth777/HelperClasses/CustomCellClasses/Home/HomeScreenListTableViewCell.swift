//
//  HomeScreenListTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class HomeScreenListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userMessageLbl: UILabel!
    @IBOutlet weak var messageTimeLbl: UILabel!


    static let identifier = "HomeScreenListTableViewCell"
//        var delegate: exploreTopicTableViewCellProtocol!
    static func nib() -> UINib{
        return UINib(nibName: "HomeScreenListTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
