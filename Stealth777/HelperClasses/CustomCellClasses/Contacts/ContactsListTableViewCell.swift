//
//  ContactsListTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

class ContactsListTableViewCell: UITableViewCell {

    // MARK: Outlets & Properties
    
    @IBOutlet weak var userImgView: UIImageViewCustomClass!
    @IBOutlet weak var forwardIconImgView: UIImageView!
    @IBOutlet weak var usernameLbl: UILabelCustomClass!
    @IBOutlet weak var selectUserBtn: UIButton!
    @IBOutlet weak var userStatusLbl: UILabel!
    @IBOutlet weak var makeAdminBtn: UIButton!

    static let identifier = "ContactsListTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "ContactsListTableViewCell", bundle: nil)
    }
    
    var callMakeAdmin:(()->Void)?
    var callSelection:(()->Void)?
    
    
    // MARK: Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Button Actions

    @IBAction func actionMakeAdmin(){
        callMakeAdmin?()
    }
    @IBAction func actionSelection(){
        callSelection?()
    }
    
}
