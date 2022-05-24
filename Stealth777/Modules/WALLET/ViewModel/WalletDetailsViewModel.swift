//
//  WalletDetailsViewModel.swift
//  Stealth777
//
//  Created by Fareed Alzoorani on 20/05/2022.
//

import Foundation
import UIKit

class WalletDetailsViewModel {


}

extension WalletDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tokenListArr.count
    }

        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 68
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        guard  let tokenCell = self.tokensListTableView.dequeueReusableCell(withIdentifier: TokenListTableViewCell.identifier , for: indexPath) as? TokenListTableViewCell else {
            return cell
        }
        
        
        let dict = self.tokenListArr[indexPath.row] as ImportedTokenList
        tokenCell.titleLbl.text = dict.name
        
        return tokenCell
    }

}
