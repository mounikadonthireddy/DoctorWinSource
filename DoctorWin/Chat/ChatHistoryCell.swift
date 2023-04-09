//
//  ChatHistoryCell.swift
//  DoctorWin
//
//  Created by AHP on 07/04/2566 BE.
//

import UIKit

class ChatHistoryCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setCornerRadius(radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWithFollowData(data: ChatModel) {
        self.userName.text = data.name ?? ""
        self.message.text = data.message ?? ""
      
    }
}
