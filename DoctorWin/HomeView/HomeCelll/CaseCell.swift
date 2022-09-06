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
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var likeLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var followBtn: UIButton!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    // @IBOutlet weak var replyBtn: UIButton!
    //    @IBOutlet weak var replyTF: UITextField!
    weak var delegate: CellActionDelegate?
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    @IBOutlet weak var imageHeiht: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        personImage.setCornerRadiusWithBorderColor(radius: 25, color: UIColor.lightGray, borderWidth: 0.2)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        self.postedPersonName.text = (homeModel.profileName ?? "")
        self.titleLable.text =  homeModel.postTitle ?? ""
        self.designation.text = homeModel.speciality ?? ""
        if let value = homeModel.discussionCount {
            self.discussion.text = "\(String(describing: value))"
        }
        if let value1 = homeModel.likeCount {
            self.likeLable.text = "\(String(describing: value1))"
        }
        self.followBtn.tag = homeModel.postUserId ?? 0
        if let urlString = homeModel.postImage {
            self.postImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
            let url = URL(string: ApiEndpoints.baseImageURL + urlString)
//            if let imageSource = CGImageSourceCreateWithURL(url! as CFURL, nil) {
//                if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
//                     let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
//                     let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
//                     print("the image width is: \(pixelWidth)")
//                     print("the image height is: \(pixelHeight)")
//
//                    let ratio = pixelWidth / pixelWidth
//                    if ratio != 0 {
//                    let newHeight = postImage.frame.width / CGFloat(ratio)
//                    imageHeiht.constant = newHeight
//                    self.layoutIfNeeded()
                    //}
                  //}
              //}
            
        } else {
            imageHeiht.constant  = 0
        }
        //  self.descriptionLable.text = homeModel.chiefComplaint
        if homeModel.bookmarkStatus ?? false {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        if homeModel.follow  {
            self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.likeStatus ?? false {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if let urlString = homeModel.profileImage {
            self.personImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        wishlistBtn.tag = homeModel.postId
        saveBtn.tag = homeModel.postId
        //        replyBtn.tag = homeModel.id
    }
    func configureDataWith(homeModel: CasesDataModel) {
        self.postedPersonName.text = (homeModel.ProfileName ?? "")
        self.titleLable.text =  homeModel.title ?? ""
        self.designation.text = homeModel.speciality ?? ""
        if let value = homeModel.discussions {
            self.discussion.text = "\(String(describing: value))"
        }
        self.likeLable.text = "\(String(describing: homeModel.like_count))"
        
        self.followBtn.tag = homeModel.id
        if let urlString = homeModel.image {
            let finalUrlString =  urlString
            
            self.postImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        
        if homeModel.bookmark_status {
            bookmarkImage.image = UIImage(named: "fmark")
        }
        if homeModel.follow  {
            self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.like_status {
            likeImage.image = UIImage(named: "fheart")
            
        }
        if let urlString = homeModel.ProfileImage {
            self.personImage.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "loginBg"))
        }
        wishlistBtn.tag = homeModel.id
        saveBtn.tag = homeModel.id
        //        replyBtn.tag = homeModel.id
    }
    @IBAction func likeClicked(_ sender: UIButton) {
        let request = ComplaintLikeRequest(complaint_id:"\(sender.tag)", user_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.likeComplaint(request: request) { result in
            DispatchQueue.main.async {
                if result.status  {
                    self.likeImage.image = UIImage(named: "fheart")
                } else {
                    self.likeImage.image = UIImage(named: "heart")
                }
            }
            
        }
        
    }
    @IBAction  func followClicked(_ sender: UIButton) {
        let request = ComplaintFollowRequest(follow_id: "\(sender.tag)", user_id: User.shared.userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                if result != nil && result == true {
                    self.followBtn.setTitle("Following", for: .normal)
                } else {
                    self.followBtn.setTitle("Follow", for: .normal)
                }
            }
            
        }
    }
    @IBAction  func saveClicked(_ sender: UIButton) {
        let request = ComplaintLikeRequest(complaint_id:"\(sender.tag)", user_id: User.shared.userID)
        
        let resource = HomeResource()
        resource.saveComplaint(request: request) { result in
            DispatchQueue.main.async {
                if result.status  {
                    self.bookmarkImage.image = UIImage(named: "fmark")
                } else {
                    self.bookmarkImage.image = UIImage(named: "mark")
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
