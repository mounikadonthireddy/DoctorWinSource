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
    var timer: Timer?
    var currentImage: UIImage?
    var currentIndex = -1
    var bannerImages : [ElearningBannerModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageview.setCornerRadius(radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setBannerImage(data: [ElearningBannerModel]) {
        pageControl.numberOfPages = data.count
        if data.count > 0 {
            bannerImages = data
        if let urlString = data[0].image {
            pageControl.numberOfPages = data.count
            pageControl.currentPage = 0
            self.startTimer()
            self.imageview.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 4.50, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        if bannerImages.count > 0 {
            currentIndex = (currentIndex == bannerImages.count - 1) ? 0 : currentIndex + 1
           
            if let urlString = self.bannerImages[self.currentIndex].image {
            
            self.imageview.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "imageBg"))
    
            self.currentImage = self.imageview.image
            }
            self.pageControl.currentPage = self.currentIndex
            
        }
    }
}
