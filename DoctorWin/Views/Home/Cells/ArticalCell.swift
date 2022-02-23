//
//  ArticalCell.swift
//  DoctorWin
//
//  Created by N517325 on 07/12/21.
//

import UIKit

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
        
        self.titleLable.text = homeModel.articalTitle
        self.personName.text = "Dr." + (homeModel.profileName ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.location ?? "")
        
        if let count = homeModel.likes {
        self.likeCount.text = "\(count)" + "Likes"
        }
        if let urlString = homeModel.articalImage {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if homeModel.caseProfileImage != "no image" {
            if let urlString = homeModel.caseProfileImage {
                let finalUrlString = ApiEndpoints.baseImageURL + urlString
                self.pesonImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
            }
        }
        
        if homeModel.bookmarkStatus ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        if homeModel.follow != "False" {
            //            self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.likeStatus ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        wishlistBtn.tag = homeModel.id ?? 0
        saveBtn.tag = homeModel.id ?? 0
    }
    func configureDataWith(homeModel: ArticalsDataModel) {
        
        self.titleLable.text = homeModel.artical_title
        self.personName.text = "Dr." + (homeModel.profile_name ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.current_job_location ?? "")
        
        if let count = homeModel.like_count {
        self.likeCount.text = "\(count)" + "Likes"
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
                self.likeCount.text = "\(result.like_count!) Likes"

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
    
}


