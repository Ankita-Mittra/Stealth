//
//  GroupRequestsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class GroupRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var sendMessage: UIButton!
    @IBOutlet weak var sendRequest: UIButton!

    @IBOutlet weak var handleRequestView: UIView!
    @IBOutlet weak var acceptLbl: UILabel!
    @IBOutlet weak var rejectLbl: UILabel!

    static let identifier = "GroupRequestsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "GroupRequestsTableViewCell", bundle: nil)
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
