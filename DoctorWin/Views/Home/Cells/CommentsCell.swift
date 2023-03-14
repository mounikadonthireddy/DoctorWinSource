//
//  CommentsCell.swift
//  DoctorWin
//
//  Created by N517325 on 31/10/21.
//

import UIKit

class CommentsCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        personImage.setCornerRadius(radius: Float(personImage.frame.height)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWith(data: CommentModel) {
        comment.text = data.comment ?? ""
        name.text = data.name ?? ""
        if let urlString = data.image {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
}
