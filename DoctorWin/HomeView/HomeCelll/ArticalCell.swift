//
//  ArticalCell.swift
//  DoctorWin
//
//  Created by N517325 on 07/12/21.
//

import UIKit
import ImageIO

class ArticalCell: UITableViewCell {
    
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: ExpandableLabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var replyTF: UITextField!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var pesonImage: UIImageView!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var imageHeiht: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pesonImage.setCornerRadius(radius: Float(self.pesonImage.frame.height)/2)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        
        self.titleLable.text = homeModel.title
        self.personName.text =  (homeModel.profileName ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.location ?? "")
        
        if let count = homeModel.likeCount {
            self.likeCount.text = "\(count)" 
        }
        if let urlString = homeModel.postedImage {
            self.postImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
            let size = self.sizeOfImageAt(url: URL(string: urlString)!)
            let ratio = Int(size?.width ?? 100) / Int(size?.height ?? 100)
            if ratio != 0 {
            let newHeight = Int(postImage.frame.width) / ratio
            imageHeiht.constant = CGFloat(newHeight)
            self.layoutIfNeeded()
            }
            
        }
       
        if homeModel.profileImage != "no image" {
            if let urlString = homeModel.profileImage {
                self.pesonImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
            }
        }
        
        if homeModel.bookmarkStatus ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        //        if homeModel.follow != "False" {
        //            //            self.followBtn.setTitle("Following", for: .normal)
        //        }
        if homeModel.likeStatus ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        wishlistBtn.tag = homeModel.id ?? 0
        saveBtn.tag = homeModel.id ?? 0
    }
    func configureDataWith(homeModel: ArticalsDataModel) {
        
        self.titleLable.text = homeModel.artical_title
        self.personName.text = (homeModel.profile_name ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.current_job_location ?? "")
        
        if let count = homeModel.like_count {
            self.likeCount.text = "\(count)"
        }
        if let urlString = homeModel.mediafile {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if homeModel.profile_image != "no image" {
            if let urlString = homeModel.profile_image {
                let finalUrlString = ApiEndpoints.baseImageURL + urlString
                self.pesonImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
            }
        }
        
        if homeModel.bookmark_status ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        
        if homeModel.like_status ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        wishlistBtn.tag = homeModel.id
        saveBtn.tag = homeModel.id 
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        
        let request = ArticalLikeRequest(art_id:"\(sender.tag)", user_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.likeArtical(request: request) { result in
            DispatchQueue.main.async {
                if  result.status {
                    self.likeImage.image = UIImage(named: "fheart")
                } else {
                    self.likeImage.image = UIImage(named: "heart")
                }
                self.likeCount.text = "\(result.like_count!)"
                
            }
            
        }
        
    }
    
    @IBAction  func saveClicked(_ sender: UIButton) {
        let request = ArticalLikeRequest(art_id:"\(sender.tag)", user_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.saveArtical(request: request) { result in
            DispatchQueue.main.async {
                if result.status  {
                    self.bookmarkImage.image = UIImage(named: "fmark")
                } else {
                    self.bookmarkImage.image = UIImage(named: "mark")
                }
            }
            
        }
    }
     func sizeOfImageAt(url: URL) -> CGSize? {
            // with CGImageSource we avoid loading the whole image into memory
            guard let source = CGImageSourceCreateWithURL(url as CFURL, nil) else {
                return nil
            }

            let propertiesOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let properties = CGImageSourceCopyPropertiesAtIndex(source, 0, propertiesOptions) as? [CFString: Any] else {
                return nil
            }

            if let width = properties[kCGImagePropertyPixelWidth] as? CGFloat,
                let height = properties[kCGImagePropertyPixelHeight] as? CGFloat {
                return CGSize(width: width, height: height)
            } else {
                return nil
            }
        }
    
}


