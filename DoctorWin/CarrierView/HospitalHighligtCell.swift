//
//  HospitalHighligtCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/05/22.
//

import UIKit

class HospitalHighligtCell: UICollectionViewCell {

    @IBOutlet weak var jobTypeImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var jobTypeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.clipsToBounds = true
        // Initialization code
    }
  
    func configureCell(with data: Hospitalspeciality) {
        self.jobTypeName.isHidden = true
        self.bgView.layer.cornerRadius = 10
        jobTypeImage.setCornerRadius(radius: 15)

        if let urlString = data.image {
            self.jobTypeImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    func configureCell(with data: Hospitalhighlight) {
        self.jobTypeName.text = data.title
        self.bgView.layer.cornerRadius = 10
        jobTypeImage.setCornerRadius(radius: 15)

        if let urlString = data.image {
            self.jobTypeImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
}
