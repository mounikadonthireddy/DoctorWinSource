//
//  AnswersCell.swift
//  DoctorWin
//
//  Created by AHP on 04/09/2565 BE.
//

import UIKit

class AnswersCell: UICollectionViewCell {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var personDesignation: UILabel!
    @IBOutlet weak var questionDes: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.setCornerRadius(radius: Float(personImage.frame.height)/2)
    }
    func configureDataWith(homeModel: AnswersModel) {
        self.personName.text = (homeModel.ProfileName ?? "")
        self.questionTitle.text =  homeModel.asked_question ?? ""
        self.personDesignation.text = homeModel.speciality ?? ""
        self.questionDes.text = homeModel.ans ?? ""

        if let urlString = homeModel.ProfileImage {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        
    }
}
