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
    var display_status: Int = 0
    var postId: Int = 0
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
    func configureDataWith(homeModel: QuestionRepliesModel) {
        
        if let userData = homeModel.userDetails {
            self.designation.text = userData.speciality ?? ""
            self.postedPersonName.text = userData.name
            if let urlString = userData.image {
                self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
            }
            
        }
      
        self.titleLable.text =  homeModel.text_description ?? ""
       
        self.discussion.text = "\(homeModel.comment_count ?? 0)"
        self.likeLable.text = "\(homeModel.like_count ?? 0)"
        if homeModel.bookmark_status ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        
        if homeModel.bookmark_status ?? false {
            likeImage.image = UIImage(named: "fheart")
        }
        if let imageData = homeModel.image {
           
            if imageData.count > 0 {
              
                self.imageHeiht.constant = 350
                if let urlString = imageData[0].image {
                    self.postImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
                }
            } else {
                imageHeiht.constant = 0
            }
        } else {
            imageHeiht.constant = 0
          
        }
        self.display_status = homeModel.display_status ?? 0
        self.postId = homeModel.id ?? 0
       
        //        wishlistBtn.tag = homeModel.id
        //        saveBtn.tag = homeModel.id
        //        replyBtn.tag = homeModel.id
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        let request = LikeRequestModel(display_status: display_status, id: self.postId, preference: Preference.like.rawValue)

        let resource = LikeSaveFollowResource()
        resource.addToWishslist(reqModel: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    if let value1 = data.like_count, value1 > 0 {
                        self.wishlistBtn.setTitle(" \(value1)", for: .normal)
                    }
                    if data.status == true {
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
        let request = LikeRequestModel(display_status: display_status, id: self.postId, preference: Preference.bookmark.rawValue)

        let resource = LikeSaveFollowResource()
        resource.addToWishslist(reqModel: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success( let data):
                    if data.status == true {
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
