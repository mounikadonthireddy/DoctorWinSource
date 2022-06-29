//
//  NewsDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 22/04/22.
//

import UIKit

class NewsDetailsCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likesLable: UILabel!
    @IBOutlet weak var commentsLable: UILabel!
    @IBOutlet weak var commentsCountLable: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        likeBtn.setCornerRadius(radius: Float(self.likeBtn.frame.height)/2)
        uploadBtn.setCornerRadius(radius: Float(self.uploadBtn.frame.height)/2)
        backBtn.setCornerRadius(radius: Float(self.backBtn.frame.height)/2)

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        
        self.titleLable.text = homeModel.title
        self.descriptionLable.text = homeModel.discription
            self.likesLable.text = "\(homeModel.likeCount ?? 0) " + "Likes"
            self.commentsLable.text = "\(homeModel.discussion ?? 0) " + "Comments"
            self.commentsCountLable.text = "\(homeModel.discussion ?? 0) " + "Comments"
       
        if let urlString = homeModel.postedImage {
            self.postImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))

            }
    }
    func configureDataWith(homeModel: ArticalsDataModel) {
        
//        self.titleLable.text = homeModel.artical_title
//        self.personName.text = "Dr." + (homeModel.profile_name ?? "")
//        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.current_job_location ?? "")
//        
//        
//        if let urlString = homeModel.mediafile {
//            let finalUrlString = ApiEndpoints.baseImageURL + urlString
//            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
//        }
//        if homeModel.profile_image != "no image" {
//            if let urlString = homeModel.profile_image {
//                let finalUrlString = ApiEndpoints.baseImageURL + urlString
//                self.pesonImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
//            }
//        }
        
        
    }
    
    
}


