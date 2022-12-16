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
    func configureDataWith(homeModel: HomeDataModel) {
        
        self.questionTitle.text =  homeModel.title ?? ""
       
        self.questionDes.text = homeModel.description ?? ""
        if let userData = homeModel.userDetails {
            self.personDesignation.text = userData.speciality ?? ""
            self.personName.text = userData.name
            if let urlString = userData.image {
                self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
            }
           // self.postId = userData.posted_id
    }
        if let groupData = homeModel.groupDetails {
            if groupData.status == true {
            self.personDesignation.text =  "by " + (homeModel.userDetails?.name ?? "")
            self.personName.text = groupData.name ?? ""
            if let urlString = groupData.image {
                self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
            }
            //self.postId = groupData.id ?? ""
        }
       
    }
       
        
    }
}
