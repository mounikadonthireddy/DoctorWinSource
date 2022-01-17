//
//  PostQuestionHeader.swift
//  DoctorWin
//
//  Created by N517325 on 10/11/21.
//

import UIKit

class PostQuestionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var postView: UIView!
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func configureCell(with data: QuestionModel) {
        postView.setCornerRadius(radius: 10)
        nameLabel.text = data.profile.profile_name
        dateLabel.text = data.create
        comment.text = data.question
        self.personImage.setCornerRadius(radius: Float(self.personImage.frame.height)/2)
        if let urlString = data.profile.profileImage {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
    
    }

}
