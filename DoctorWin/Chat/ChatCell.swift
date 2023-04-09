//
//  ChatCell.swift
//  DoctorWin
//
//  Created by AHP on 05/04/2566 BE.
//

import UIKit

class ChatCell: UITableViewCell {
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.setCornerRadius(radius: Float(personImage.frame.width)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWithFollowData(data: ChatListModel) {
        self.name.text = data.name ?? ""
        self.nameType.text = data.speciality ?? ""
        if let urlString = data.image {
         self.personImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    func cellConfigureWithFollowData(data: RecentChatModel) {
        self.name.text = data.relatedname ?? ""
        self.nameType.text = data.message ?? ""
        if let urlString = data.image {
         self.personImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
