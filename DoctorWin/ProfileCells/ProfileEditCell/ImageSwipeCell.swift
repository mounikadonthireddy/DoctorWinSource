//
//  ImageSwipeCell.swift
//  DoctorWin
//
//  Created by AHP on 07/10/2565 BE.
//

import UIKit

class ImageSwipeCell: UITableViewCell {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var dataImageView: UIImageView!
    var timer: Timer?
    var currentImage: UIImage?
    var currentIndex = -1
    var bannerImages : [ProductImageModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func loadCellBannerImages(data: [ProductImageModel]) {
        self.bannerImages = data
        if bannerImages.count > 0 {
            pageControl.numberOfPages = bannerImages.count
            pageControl.currentPage = 0
            self.startTimer()
            if let urlString = bannerImages[0].image {
                self.dataImageView.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "imageBg"))
            }
        }
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        if bannerImages.count > 0 {
            currentIndex = (currentIndex == bannerImages.count - 1) ? 0 : currentIndex + 1
            if let urlString = self.bannerImages[self.currentIndex].image {
            
            self.dataImageView.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "imageBg"))
    
            self.currentImage = self.dataImageView.image
            }
            self.pageControl.currentPage = self.currentIndex
            
        }
    }
}
