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
            bookmarkImage.image = UIImage(named: "bookmark")
        }
        if homeModel.follow != "False" {
            //            self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.likeStatus ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
    }
    
    
}


