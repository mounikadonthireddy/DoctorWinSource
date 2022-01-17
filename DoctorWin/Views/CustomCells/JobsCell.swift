//
//  JobsCell.swift
//  DoctorWin
//
//  Created by N517325 on 25/10/21.
//

import UIKit

class JobsCell: UICollectionViewCell {

    @IBOutlet weak var jobTypeImage: UIImageView!
    
    @IBOutlet weak var jobTypeName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.jobTypeImage.clipsToBounds = true
        self.jobTypeImage.layer.cornerRadius = self.jobTypeImage.frame.height/2
        
        // Initialization code
    }
    func configureCell(with data: JobCategoryDataModel) {
        self.jobTypeName.text = data.title
        if let urlString = data.image {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.jobTypeImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }

}
