//
//  PostReplyCell.swift
//  DoctorWin
//
//  Created by N517325 on 10/11/21.
//

import UIKit

class PostReplyCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(with data: Answers) {
        nameLabel.text = data.profile.profile_name
        dateLabel.text = data.create
        comment.text = data.comment
        self.personImage.setCornerRadius(radius: Float(self.personImage.frame.height)/2)

        if let urlString = data.profile.profileImage {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
}
