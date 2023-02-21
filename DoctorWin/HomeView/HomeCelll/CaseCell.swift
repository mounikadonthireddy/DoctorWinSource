//
//  CaseCell.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/04/22.
//

import UIKit

class CaseCell: UITableViewCell {
    
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var designation: UILabel!
    //@IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLable: UILabel!
//    @IBOutlet weak var likeLable: UILabel!
//    @IBOutlet weak var dateLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var commentProfileImage: UIImageView!
    weak var delegate: CellActionDelegate?
    @IBOutlet weak var personImage: UIImageView!
//    @IBOutlet weak var likeImage: UIImageView!
//    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageHeiht: NSLayoutConstraint!
    var postId: Int = 0
    var display_status: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setCornerRadius(radius: 10)
        personImage.setCornerRadiusWithBorderColor(radius: 25, color: UIColor.lightGray, borderWidth: 0.2)
        commentView.setCornerRadius(radius: Float(commentView.frame.height/2))
        commentProfileImage.setCornerRadius(radius: Float(commentProfileImage.frame.height/2))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        self.titleLable.text =  homeModel.title ?? ""
        self.subTitleLable.attributedText =  homeModel.description?.htmlToAttributedString
        self.postId = homeModel.id
        self.display_status = homeModel.display_status ?? 0
       // self.dateLable.text = homeModel.posted_date ?? ""
 
//        if let value = homeModel.comment_count {
//            self.c.setTitle("\(value)", for: .normal)
//
//        }
        if let value1 = homeModel.like_count {
            self.wishlistBtn.setTitle("\(value1)", for: .normal)
        }
        if homeModel.bookmark_status ?? false {
            saveBtn.setImage(UIImage(named: "fmark"), for: .normal)
         
        }
        if homeModel.follow_status ?? false  {
            self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.like_status ?? false {
            wishlistBtn.setImage(UIImage(named: "fheart"), for: .normal)
        }
        
       
            if let userData = homeModel.userDetails {
                self.designation.text = userData.speciality ?? ""
                self.postedPersonName.text = userData.name
                if let urlString = userData.image {
                    self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
                }
               // self.postId = userData.posted_id
        }
            if let groupData = homeModel.groupDetails {
                if groupData.status == true {
                self.designation.text =  "by " + (homeModel.userDetails?.name ?? "")
                self.postedPersonName.text = groupData.name ?? ""
                if let urlString = groupData.image {
                    self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
                }
              //  self.postId = groupData.id ?? ""
            }
           
        }
        if let imageData = homeModel.image {
            pageControl.numberOfPages = imageData.count
            if imageData.count > 0 {
                pageControl.isHidden = false
                self.imageHeiht.constant = 250
                if let urlString = imageData[0].image {
                    self.postImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
                }
            } else {
                imageHeiht.constant = 0
            }
        } else {
            imageHeiht.constant = 0
            pageControl.isHidden = true
        }
    }
    func configureProfileData(profileData: PostedUserDetailsModel?) {
        if let userData = profileData {
            self.designation.text = userData.speciality ?? ""
            self.postedPersonName.text = userData.name
            if let urlString = userData.image {
                self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
            }
           // self.postId = userData.posted_id
    }
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        
        let request = LikeRequestModel(display_status: display_status, id: self.postId, preference: Preference.like.rawValue)

        let resource = LikeSaveFollowResource()
        resource.addToWishslist(reqModel: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    if data.status == true {
                        self.wishlistBtn.setImage(UIImage(named: "fheart"), for: .normal)
                        //self.likeLable.text = "\(data.like_count ?? 0)"
                    } else {
                        self.wishlistBtn.setImage(UIImage(named: "heart"), for: .normal)
                       // self.likeLable.text = "\((count ?? 1) - 1)"
                    }
                case .failure(_):
                    print("")
                }
            }

        }
        
    }
    @IBAction  func followClicked(_ sender: UIButton) {
        let request = ComplaintFollowRequest(follow_id: "\(sender.tag)", user_id: User.shared.userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if data != nil && data == true {
                        self.followBtn.setTitle("Following", for: .normal)
                    } else {
                        self.followBtn.setTitle("Follow", for: .normal)
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
                        self.saveBtn.setImage(UIImage(named: "fmark"), for: .normal)
                    }
                    else {
                        self.saveBtn.setImage(UIImage(named: "mark"), for: .normal)
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
        //        replyTF.resignFirstResponder()
        //        if replyTF.text != "" {
        //            let request = PostReplyRequest(case_id:"\(sender.tag)", profile: User.shared.userID, comment: replyTF.text!)
        //
        //            let resource = HomeResource()
        //            resource.replyComplaint(request: request) { result in
        //                DispatchQueue.main.async {
        //                    if result.status == "true" {
        //                        if let value = result.discussion {
        //                            self.discussion.text = "\(String(describing: value)) Discussions"
        //                            self.replyTF.text = ""
        //                        }
        //                    }
        //
        //                }
        //
        //            }
        //        }
    }
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
