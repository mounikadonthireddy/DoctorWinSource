//
//  ReplyCell.swift
//  DoctorWin
//
//  Created by AHP on 10/10/2565 BE.
//

import UIKit

class ReplyCell: UITableViewCell {
    @IBOutlet weak var imageHeiht: NSLayoutConstraint!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var designation: UILabel!
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: ExpandableLabel!
    @IBOutlet weak var likeLable: UILabel!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    weak var delegate: CellActionDelegate?
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.setCornerRadiusWithBorderColor(radius: 25, color: UIColor.lightGray, borderWidth: 0.2)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureDataWith(homeModel: AnswersModel) {
        self.postedPersonName.text = (homeModel.ProfileName ?? "")
        self.titleLable.text =  homeModel.ans ?? ""
        self.designation.text = homeModel.speciality ?? ""
        self.discussion.text = "\(homeModel.number_of_comment ?? 0)"
        self.likeLable.text = "\(homeModel.number_of_like ?? 0)"
        if homeModel.bookmark_status ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        
        if homeModel.bookmark_status ?? false {
            likeImage.image = UIImage(named: "fheart")
        }
        if let imageStr = homeModel.posted_ans_image {
            self.postImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + imageStr), placeholderImage: UIImage(named: "loginBg"))
        }
        if let urlString = homeModel.ProfileImage {
            self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        //        wishlistBtn.tag = homeModel.id
        //        saveBtn.tag = homeModel.id
        //        replyBtn.tag = homeModel.id
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.likeComplaint(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if data.status  {
                        self.likeImage.image = UIImage(named: "fheart")
                    } else {
                        self.likeImage.image = UIImage(named: "heart")
                    }
                case .failure(_):
                    print("")
                }
            }
            
        }
        
    }
    
    @IBAction  func saveClicked(_ sender: UIButton) {
        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.saveComplaint(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success( let data):
                    if data.status {
                        self.bookmarkImage.image = UIImage(named: "fmark")
                    }
                    else {
                        self.bookmarkImage.image = UIImage(named: "mark")
                    }
                case .failure: break
                    //debug
                }
            }
            
        }
    }
    @IBAction  func shareClicked(_ sender: UIButton) {
        
    }
    @IBAction func replyClicked(_ sender: UIButton) {
        
    }
}
