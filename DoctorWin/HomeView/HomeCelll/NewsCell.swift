//
//  NewsCell.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var discussion: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var descriptionLable: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    // @IBOutlet weak var replyBtn: UIButton!
   // @IBOutlet weak var replyTF: UITextField!
    weak var delegate: CellActionDelegate?
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var bookmarkImage: UIImageView!
    var postId: Int = 0
    var display_status: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureData(homeModel: HomeDataModel) {
        self.titleLable.text =  homeModel.title ?? ""
        self.descriptionLable.text =  homeModel.description ?? ""
        self.postId = homeModel.id
        self.display_status = homeModel.display_status ?? 0
       
        if let value = homeModel.comment_count {
            self.discussion.text = "\(value)"

        }
        if let value1 = homeModel.like_count {
            self.wishlistBtn.setTitle("\(value1)", for: .normal)
        }
        if homeModel.bookmark_status ?? false {
            saveBtn.setImage(UIImage(named: "fmark"), for: .normal)
         
        }
        if homeModel.follow_status ?? false  {
            //self.followBtn.setTitle("Following", for: .normal)
        }
        if homeModel.like_status ?? false {
            wishlistBtn.setImage(UIImage(named: "fheart"), for: .normal)
        }
        
       
            if let userData = homeModel.userDetails {
            
                self.postedPersonName.text = userData.name
                
        }
            if let groupData = homeModel.groupDetails {
                if groupData.status == true {
              
                self.postedPersonName.text = groupData.name ?? ""
              
            }
           
        }
        if let imageData = homeModel.image {
          
            if imageData.count > 0 {
               
              
                if let urlString = imageData[0].image {
                    self.postImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
                }
            }
        }
    }
    @IBAction func likeClicked(_ sender: UIButton) {
//        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
//
//        let resource = HomeResource()
//        resource.likeComplaint(request: request) { result in
//            DispatchQueue.main.async {
//                switch result {
//               case .success(let data):
//                    if data.status  {
//                        self.likeImage.image = UIImage(named: "fheart")
//                    } else {
//                        self.likeImage.image = UIImage(named: "heart")
//                    }
//                case .failure(_):
//                    print("")
//                }
//                
//            }
//
//        }
        
    }
    @IBAction  func followClicked(_ sender: UIButton) {
//        let request = ComplaintFollowRequest(follow_id: "\(sender.tag)", user_id: User.shared.userID)
//        let resource = HomeResource()
//        resource.followComplaint(request: request) { result in
//            DispatchQueue.main.async {
//                if result != nil && result == true {
//                    self.followBtn.setTitle("Following", for: .normal)
//                } else {
//                    self.followBtn.setTitle("Follow", for: .normal)
//                }
//            }
//
//        }
    }
    @IBAction  func saveClicked(_ sender: UIButton) {
//        let request = ComplaintLikeRequest(achievement_id: "\(sender.tag)", dworks_id: User.shared.userID)
//
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
//                   //debug
//                }
//            }
//
//        }
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

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
