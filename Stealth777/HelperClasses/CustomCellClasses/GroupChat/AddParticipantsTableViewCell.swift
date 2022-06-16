//
//  AddParticipantsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 24/03/2022.
//

import UIKit

class AddParticipantsTableViewCell: UITableViewHeaderFooterView {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var username: UITableView!


    static let identifier = "AddParticipantsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "AddParticipantsTableViewCell", bundle: nil)
    }
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
