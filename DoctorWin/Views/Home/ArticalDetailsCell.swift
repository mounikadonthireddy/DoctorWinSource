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
        
        self.titleLable.text = homeModel.articalTitle
        self.descriptionLable.text = homeModel.articalDiscription

        self.personName.text = "Dr." + (homeModel.profileName ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.location ?? "")
        
        
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
        
        
    }
    func configureDataWith(homeModel: ArticalsDataModel) {
        
        self.titleLable.text = homeModel.artical_title
        self.personName.text = "Dr." + (homeModel.profile_name ?? "")
        self.designation.text = (homeModel.speciality ?? "") + " " + (homeModel.current_job_location ?? "")
        
        
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
        
        
    }
    
    
}


