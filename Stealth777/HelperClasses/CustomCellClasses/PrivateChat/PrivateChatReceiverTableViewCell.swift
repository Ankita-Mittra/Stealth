//
//  PrivateChatReceiverTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class PrivateChatReceiverTableViewCell: UITableViewCell {


    // MARK: - Outlets & Properties
    
    @IBOutlet weak var msgBodyLbl: UILabelCustomClass!
    @IBOutlet weak var msgTimelbl: UILabel!
    @IBOutlet weak var msgTailImgView: UIImageView!

    static let identifier = "PrivateChatReceiverTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "PrivateChatReceiverTableViewCell", bundle: nil)
    }
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        self.initialSetup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialSetup(){
        
        if LocalizationSystem.sharedInstance.getLanguage() == enumLanguageCodes.arabicLanguage.rawValue {
            self.msgTailImgView.image = self.msgTailImgView.image?.withHorizontallyFlippedOrientation()
        }
    }
    
}
