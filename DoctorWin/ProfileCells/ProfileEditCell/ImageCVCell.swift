//
//  ImageCVCell.swift
//  PatienApp
//
//  Created by AHP on 23/09/2565 BE.
//

import UIKit
import SDWebImage
struct ImageBannerModel: Codable {
    let image: String?
}

class ImageCVCell: UICollectionViewCell {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageView: UIImageView!
    var timer: Timer?
    var currentImage: UIImage?
    var currentIndex = -1
    var bannerImages : [ImageBannerModel] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.setCornerRadius(radius: 10)
        // Initialization code
    }
    func loadCellBannerImages(data: [ImageBannerModel]) {
        self.bannerImages = data
        if bannerImages.count > 0 {
            pageControl.numberOfPages = bannerImages.count
            pageControl.currentPage = 0
            self.startTimer()
            if let urlString = bannerImages[0].image {
                self.imageView.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "imageBg"))
            }
        }
    }
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 4.5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction(){
        if bannerImages.count > 0 {
            currentIndex = (currentIndex == bannerImages.count - 1) ? 0 : currentIndex + 1
            if let urlString = self.bannerImages[self.currentIndex].image {
            
            self.imageView.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "imageBg"))
    
            self.currentImage = self.imageView.image
            }
            self.pageControl.currentPage = self.currentIndex
            
        }
    }
}
