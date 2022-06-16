//
//  GroupRequestsTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 10/03/2022.
//

import UIKit

protocol GroupRequestsTableViewCellProtocol{
    func sendRequestBtnSelected(cell: GroupRequestsTableViewCell)
    func sendMessageBtnSelected(cell: GroupRequestsTableViewCell)
}

protocol GroupRequestsTableViewCellProtocolForRequestActions{
    func acceptRequest(cell: GroupRequestsTableViewCell)
    func rejectRequest(cell: GroupRequestsTableViewCell)
}


class GroupRequestsTableViewCell: UITableViewCell {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var sendMessage: UIButton!
    @IBOutlet weak var sendRequest: UIButton!
    @IBOutlet weak var requestSent: UIButton!
    @IBOutlet weak var handleRequestView: UIView!
    @IBOutlet weak var acceptLbl: UILabel!
    @IBOutlet weak var rejectLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var bioLbl : UILabel!
    @IBOutlet weak var userImgView : UIImageView!

    static let identifier = "GroupRequestsTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "GroupRequestsTableViewCell", bundle: nil)
    }
    
    var delegate: GroupRequestsTableViewCellProtocol?
    var requestActionDelegates: GroupRequestsTableViewCellProtocolForRequestActions?

    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Button Actions
    
    @IBAction func sendRequestBtnAction(_ sender: Any) {
        self.delegate?.sendRequestBtnSelected(cell: self)
    }
    
    @IBAction func sendMessageBtnAction(_ sender: Any) {
        self.delegate?.sendMessageBtnSelected(cell: self)
    }
    
    @IBAction func acceptRequestBtnAction(_ sender: Any) {
        self.requestActionDelegates?.acceptRequest(cell: self)
    }
    
    @IBAction func rejectRequestBtnAction(_ sender: Any) {
        self.requestActionDelegates?.rejectRequest(cell: self)
    }

}
