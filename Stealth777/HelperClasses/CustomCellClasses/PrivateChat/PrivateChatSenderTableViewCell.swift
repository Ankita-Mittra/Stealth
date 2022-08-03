//
//  PrivateChatSenderTableViewCell.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 04/03/2022.
//

import UIKit

class PrivateChatSenderTableViewCell: UITableViewCell {

    // MARK: - Outlets & Properties
    
    @IBOutlet weak var msgBodyLbl: UILabelCustomClass!
    @IBOutlet weak var msgTimelbl: UILabel!
    @IBOutlet weak var seenMsgImgView: UIImageView!
    @IBOutlet weak var msgTailImgView: UIImageView!

    static let identifier = "PrivateChatSenderTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "PrivateChatSenderTableViewCell", bundle: nil)
    }
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        if LocalizationSystem.sharedInstance.getLanguage() == enumLanguageCodes.arabicLanguage.rawValue {
            self.msgTailImgView.image = self.msgTailImgView.image?.withHorizontallyFlippedOrientation()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(obj:MessageModel?, privateKey: String){
//        let decryptedMsg = CommonFxns.decryptMsg(cipherText: obj?.msg?.text ?? emptyStr, publickey: obj?.senderPbKey ?? emptyStr, privateKey: privateKey)
//        print("decryptedMsg///...", decryptedMsg)
        
        msgBodyLbl.text = obj?.msg?.text
        msgTimelbl.text = CommonFxns.getDateFromMilliSeconds(mSeconds: obj?.sendTime ?? 0)
    }
    
}
