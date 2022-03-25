//
//  HomeScreenListTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class HomeScreenListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets & Properties
    
    @IBOutlet weak var forwardImgView: UIImageView!
    @IBOutlet weak var chatUsernameLbl: UILabel!
    @IBOutlet weak var userMessageLbl: UILabel!
    @IBOutlet weak var messageTimeLbl: UILabel!
    @IBOutlet weak var unreadMessageCountLbl: UILabel!
    @IBOutlet weak var chatUserImgView: UIImageView!

    static let identifier = "HomeScreenListTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "HomeScreenListTableViewCell", bundle: nil)
    }
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.initialSetup()
    }
    
    func initialSetup(){
        
        if LocalizationSystem.sharedInstance.getLanguage() == enumLanguageCodes.arabicLanguage.rawValue {
            self.forwardImgView.image = self.forwardImgView.image?.withHorizontallyFlippedOrientation()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
