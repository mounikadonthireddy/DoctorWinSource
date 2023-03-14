//
//  PopularCell.swift
//  DoctorWin
//
//  Created by AHP on 12/10/2565 BE.
//

import UIKit

class PopularCell: UITableViewCell {

    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var likeLable: UILabel!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        stackView.setCornerRadius(radius: Float(stackView.frame.height)/2)
        personImage.setCornerRadius(radius: Float(personImage.frame.height)/2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureDataWith(homeModel: AnswersModel) {
        self.postedPersonName.text = (homeModel.ProfileName ?? "")
        self.titleLable.text =  homeModel.ans ?? ""
        self.designation.text = homeModel.speciality ?? ""
        self.questionLbl.text = homeModel.asked_question ?? ""
     //   self.discussion.text = "\(homeModel.dis ?? 0)"
        self.likeLable.text = "\(homeModel.number_of_like ?? 0)"
        if homeModel.bookmark_status ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        
        if homeModel.bookmark_status ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if let urlString = homeModel.ProfileImage {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
//        wishlistBtn.tag = homeModel.id
//        saveBtn.tag = homeModel.id
        //        replyBtn.tag = homeModel.id
    }
    func configureDataWith(homeModel: HomeDataModel) {
        self.postedPersonName.text = homeModel.userDetails?.name ?? ""
        self.titleLable.attributedText =  homeModel.description?.convertToAttributedFromHTML()
        self.designation.text = homeModel.userDetails?.speciality ?? ""
        self.questionLbl.text = homeModel.title ?? ""
     //   self.discussion.text = "\(homeModel.dis ?? 0)"
        self.likeLable.text = "\(homeModel.like_count ?? 0)"
        if homeModel.bookmark_status ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        
        if homeModel.bookmark_status ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if let urlString = homeModel.userDetails?.image {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
//        wishlistBtn.tag = homeModel.id
//        saveBtn.tag = homeModel.id
        //        replyBtn.tag = homeModel.id
    }
    @IBAction func likeClicked(_ sender: UIButton) {
//        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
//        
//        let resource = HomeResource()
//        resource.likeComplaint(request: request) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let data):
//                    if data.status  {
//                        self.likeImage.image = UIImage(named: "fheart")
//                    } else {
//                        self.likeImage.image = UIImage(named: "heart")
//                    }
//                case .failure(_):
//                    print("")
//                }
//            }
//            
//        }
        
    }
    
    @IBAction  func saveClicked(_ sender: UIButton) {
//        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
//        let resource = HomeResource()
//        resource.saveComplaint(request: request) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success( let data):
//                    if data.status {
//                        self.bookmarkImage.image = UIImage(named: "fmark")
//                    }
//                    else {
//                        self.bookmarkImage.image = UIImage(named: "mark")
//                    }
//                case .failure: break
//                    //debug
//                }
//            }
//
//        }
    }
    @IBAction  func shareClicked(_ sender: UIButton) {
        
    }
    @IBAction func replyClicked(_ sender: UIButton) {
        
    }
}
