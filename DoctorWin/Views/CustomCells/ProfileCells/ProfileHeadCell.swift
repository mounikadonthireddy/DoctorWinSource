//
//  ProfileHeadCell.swift
//  DoctorWin
//
//  Created by N517325 on 30/10/21.
//

import UIKit

class ProfileHeadCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var resumeView : UIView!
    @IBOutlet weak var cases : UILabel!
    @IBOutlet weak var appliedjobs : UILabel!
    @IBOutlet weak var news : UILabel!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var speacility : UILabel!
    @IBOutlet weak var following : UILabel!
    @IBOutlet weak var followers : UILabel!
    @IBOutlet weak var previewBtn : UIButton!
    @IBOutlet weak var followingBtn : UIButton!
    @IBOutlet weak var followersBtn : UIButton!
    @IBOutlet weak var appliedBtn : UIButton!
    @IBOutlet weak var casesBtn : UIButton!
    @IBOutlet weak var newsBtn : UIButton!
    @IBOutlet weak var logoutBtn : UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width/2
        self.profileImage.layer.borderWidth = 1
        self.profileImage.layer.borderColor = UIColor.lightGray.cgColor
        
        self.resumeView.clipsToBounds = true
        self.resumeView.layer.cornerRadius = 10
        
        self.previewBtn.clipsToBounds = true
        self.previewBtn.layer.cornerRadius = self.previewBtn.frame.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cellConfigureWith(data: ProfileDataModel, section: Int) {

        if let caseCount = data.casePost {
            self.cases.text = "\(caseCount)"
        }
        
        if let newsCount = data.newsPost {
            self.news.text = "\(newsCount)"
        }
        if let appliedJobCount = data.appliedJobs {
            self.appliedjobs.text = "\(appliedJobCount)"
        }
        if let follwersCount = data.follow {
            self.followers.text = "\(follwersCount)"
        }
        if let follwingCount = data.following {
            self.following.text = "\(follwingCount)"
        }
        self.name.text = data.profileName
//        self.speacility.text = data.currentDepartment + "  At " + data.currentInstitute!
        
        if let urlString = data.profileImage {
            let finalUrlString = "http://3.132.212.116:8000" + urlString
            self.profileImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))

        }
    }
}
