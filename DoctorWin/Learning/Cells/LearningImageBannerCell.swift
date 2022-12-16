//
//  LearningImageBannerCell.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import UIKit

class LearningImageBannerCell: UITableViewCell {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageview.setCornerRadius(radius: 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setBannerImage(data: [ElearningBannerModel]) {
        pageControl.numberOfPages = data.count
        if let urlString = data[0].image {
            self.imageview.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    
}
