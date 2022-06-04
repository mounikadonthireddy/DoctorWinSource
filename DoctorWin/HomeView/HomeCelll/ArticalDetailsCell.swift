//
//  ArticalDetailsCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 23/02/22.
//

import UIKit

class ArticalDetailsCell: UITableViewCell {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var pesonImage: UIImageView!
    
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
        self.descriptionLable.text = homeModel.discription
        self.personName.text =  (homeModel.profileName ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + "| Artical"
        
       
        if let urlString = homeModel.postedImage {
            self.postImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))

            }
        if homeModel.profileImage != "no image" {
            if let urlString = homeModel.profileImage {
                self.pesonImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
            }
        }
            
    }
    func configureDataWith(homeModel: ArticalsDataModel) {
        
        self.titleLable.text = homeModel.title
        self.personName.text = (homeModel.ProfileName ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.current_job_location ?? "")
        
//        if let count = homeModel.like_count {
//            self.likeCount.text = "\(count)"
//        }
        if let urlString = homeModel.image {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        if homeModel.ProfileImage != "no image" {
            if let urlString = homeModel.ProfileImage {
                self.pesonImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
            }
        }
        
    }
    
    
}


