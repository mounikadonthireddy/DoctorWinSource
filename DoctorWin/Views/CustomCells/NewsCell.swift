//
//  NewsCell.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var postedDate: UILabel!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var bookmarkBtn: UIButton!
    @IBOutlet weak var wishlist: UIImageView!
    @IBOutlet weak var bookmark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.shadowView.dropShadow()
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureCell(with dataModel: NewsDataModel) {
        self.postedPersonName.text = dataModel.username
        self.postTitle.text = dataModel.artical_title
        if let urlString = dataModel.artical_image {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.postImageView.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if dataModel.like_status ?? false {
            self.wishlist.image = UIImage(named: "fheart")
        }
        if dataModel.bookmark_status ?? false {
            self.bookmark.image = UIImage(named: "fstar")
        }
        
        if let date = dataModel.created_date {
            let days = calculateDaysfrom(date: date)
            if days == 1 {
                self.postedDate.text = "\(days) day ago"
            }
            else {
                self.postedDate.text = "\(days) days ago"
            }
        }
        wishlistBtn.tag = dataModel.id
        bookmarkBtn.tag = dataModel.id
    }
    func configureCell(with dataModel: NewscategoryDataModel) {
        self.postedPersonName.text = dataModel.username
        self.postTitle.text = dataModel.title
        if let urlString = dataModel.image {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            
            self.postImageView.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if dataModel.like_status ?? false {
            self.wishlist.image = UIImage(named: "fheart")
        }
        if dataModel.bookmark_status ?? false {
            self.bookmark.image = UIImage(named: "fstar")
        }
        
        if let date = dataModel.created_date {
            let days = calculateDaysfrom(date: date)
            if days == 1 {
                self.postedDate.text = "\(days) day ago"
            }
            else {
                self.postedDate.text = "\(days) days ago"
            }
        }
        wishlistBtn.tag = dataModel.id
        bookmarkBtn.tag = dataModel.id
    }
    
    func calculateDaysfrom(date: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS"
        let formatedStartDate = dateFormatter.date(from: date)
        let currentDate = Date()
        _ = Set<Calendar.Component>([ .day])
        let differenceOfDate =  Calendar.current.dateComponents([.day], from: formatedStartDate!, to: currentDate).day!
        return differenceOfDate
    }
    
    @IBAction func likeClicked(_ sender: UIButton) {
        
        let request = NewsLikeRequest(user_id: User.shared.userID, artical_id:"\(sender.tag)")
        
        let resource = HomeResource()
        resource.likeNews(request: request) { result in
            DispatchQueue.main.async {
                if  result.status {
                    self.wishlist.image = UIImage(named: "fheart")
                } else {
                    self.wishlist.image = UIImage(named: "heart")
                }

            }
            
        }
        
    }

    @IBAction  func saveClicked(_ sender: UIButton) {
        let request = NewsLikeRequest(user_id: User.shared.userID, artical_id: "\(sender.tag)")

        let resource = HomeResource()
        resource.saveNews(request: request) { result in
            DispatchQueue.main.async {
                if result.status  {
                    self.bookmark.image = UIImage(named: "fstar")
                } else {
                    self.bookmark.image = UIImage(named: "star")
                }
            }
            
        }
    }
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
