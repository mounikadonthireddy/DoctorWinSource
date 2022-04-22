//
//  ExamCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class ExamCell: UITableViewCell {


    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var option1Btn: UIButton!
    @IBOutlet weak var option2Btn: UIButton!
    @IBOutlet weak var option3Btn: UIButton!
    @IBOutlet weak var option4Btn: UIButton!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        option1Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        option2Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        option3Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        
        option4Btn.setCornerRadiusWithBorderColor(radius: 5, color: UIColor.lightGray, borderWidth: 1)
        self.personImage.setCornerRadiusWithBorderColor(radius: 20, color: UIColor.lightGray, borderWidth: 0.2)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        self.designation.text = homeModel.subject
        self.postedPersonName.text = homeModel.exam
        self.titleLable.text = homeModel.question
        self.option1Btn.setTitle("   A.\(homeModel.option1 ?? "")", for: .normal)
        self.option2Btn.setTitle("   B.\(homeModel.option2 ?? "")", for: .normal)
        self.option3Btn.setTitle("   C.\(homeModel.option3 ?? "")", for: .normal)
        self.option4Btn.setTitle("   D.\(homeModel.option4 ?? "")", for: .normal)



//        if homeModel.follow != "False" {
//            self.followBtn.setTitle("Following", for: .normal)
//        }
//        if homeModel.likeStatus ?? false {
//            likeImage.image = UIImage(named: "fheart")
//
//        }
//        if homeModel.bookmarkStatus ?? false {
//            bookmarkImage.image = UIImage(named: "fmark")
//        }
        if let urlString = homeModel.profileImage {

            self.personImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
    }
    func configureData(homeModel: PollsDataModel) {
//        self.designation.text = homeModel.speciality
//        self.postedPersonName.text = homeModel.username
//        self.titleLable.text = homeModel.poll_title
//        let days = Date().offsetFrom(dateStr: homeModel.created_date)
//
//        self.followBtn.tag = homeModel.poll_user
//
//        //        if let value = homeModel.discussion {
//        //            self.discussion.text = "\(String(describing: value)) Discussions"
//        //
//        //        }
//
//        if homeModel.follow != "False" {
//            self.followBtn.setTitle("Following", for: .normal)
//        }
////        if homeModel.like_status {
////            likeImage.image = UIImage(named: "fheart")
////
////        }
////        if homeModel.bookmark_status ?? false  {
////            bookmarkImage.image = UIImage(named: "fmark")
////        }
//        if let urlString = homeModel.profile_image {
//            let finalUrlString = "http://3.132.212.116:8000" + urlString
//
//            self.personImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
//        }
    }
    
    @IBAction  func followClicked(_ sender: UIButton) {
        let request = ComplaintFollowRequest(follow_id: "\(sender.tag)", user_id: User.shared.userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                if result != nil && result == "true" {
                    self.followBtn.setTitle("Following", for: .normal)
                } else {
                    self.followBtn.setTitle("Follow", for: .normal)
                }
            }
            
        }
    }
   
}
