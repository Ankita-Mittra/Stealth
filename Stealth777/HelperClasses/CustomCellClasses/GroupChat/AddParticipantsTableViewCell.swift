//
//  AddParticipantsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 24/03/2022.
//

import UIKit

protocol AddParticipantsTableViewCellProtocol{
    func viewAllMembersBtnSelected(cell: AddParticipantsTableViewCell)
    func addParticipantsBtnSelected(cell: AddParticipantsTableViewCell)
}

class AddParticipantsTableViewCell: UITableViewHeaderFooterView {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var addParticipantsLbl: UILabel!
    @IBOutlet weak var viewAllMembersBtn: UIButton!
    
    static let identifier = "AddParticipantsTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "AddParticipantsTableViewCell", bundle: nil)
    }
    
    var delegate: AddParticipantsTableViewCellProtocol?
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func viewAllMembersBtnAction(_ sender: Any) {
        self.delegate?.viewAllMembersBtnSelected(cell: self)
        
    }
    
    @IBAction func addParticipantsBtnAction(_ sender: Any) {
        self.delegate?.addParticipantsBtnSelected(cell: self)

    }
    
}
