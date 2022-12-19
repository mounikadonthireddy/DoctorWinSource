//
//  JobsCell.swift
//  DoctorWin
//
//  Created by N517325 on 25/10/21.
//

import UIKit

class JobsCell: UICollectionViewCell {

    @IBOutlet weak var jobTypeImage: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var jobDesName: UILabel!
    @IBOutlet weak var jobTypeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bgView.clipsToBounds = true
        self.bgView.layer.cornerRadius = 10
        
        // Initialization code
    }
    func configureCell(with data: JobCategoryModel) {
        self.jobTypeName.text = data.category
       // self.jobDesName.text = data.about

        if let urlString = data.image {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.jobTypeImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }

}
