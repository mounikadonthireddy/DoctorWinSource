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
    @IBOutlet weak var discussionBtn: UIButton!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLable: UILabel!
//    @IBOutlet weak var likeLable: UILabel!
    @IBOutlet weak var categoryLable: UILabel!
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
    var userPostedID: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bgView.setCornerRadius(radius: 10)
        personImage.setCornerRadiusWithBorderColor(radius: 25, color: UIColor.lightGray, borderWidth: 0.2)
        commentView.setCornerRadius(radius: Float(commentView.frame.height/2))
        commentProfileImage.setCornerRadius(radius: Float(commentProfileImage.frame.height/2))
        followBtn.btn_setCornerRadius(radius: 8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configureData(homeModel: HomeDataModel) {
        self.titleLable.text =  homeModel.title ?? ""
        self.titleLable.setLineSpacing()
        self.postId = homeModel.id
        self.display_status = homeModel.display_status ?? 0
        if let data = homeModel.text_description {
            self.subTitleLable.text = data
            self.subTitleLable.numberOfLines = 5
            if subTitleLable.text?.count ?? 0 > 300 {
                DispatchQueue.main.async {
                    self.subTitleLable.addTrailing(with: "... ", moreText: "Readmore", moreTextFont: self.subTitleLable.font!, moreTextColor: .blue)
                }
            }
        } else {
            self.subTitleLable.text = homeModel.description ?? ""
        }

       // self.dateLable.text = homeModel.posted_date ?? ""
 
        if let value = homeModel.comment_count, value > 0 {
            self.discussionBtn.setTitle(" \(value)", for: .normal)
        }
        if let value1 = homeModel.like_count, value1 > 0 {
            self.wishlistBtn.setTitle(" \(value1)", for: .normal)
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
                self.userPostedID = userData.posted_id ?? ""
        }
            if let groupData = homeModel.groupDetails {
                if groupData.status == true {
                self.designation.text =  "by " + (homeModel.userDetails?.name ?? "")
                self.postedPersonName.text = groupData.name ?? ""
                if let urlString = groupData.image {
                    self.personImage.sd_setImage(with: URL(string: ApiEndpoints.baseImageURL + urlString), placeholderImage: UIImage(named: "loginBg"))
                }
           // self.userPostedID = groupData.id ?? ""
            }
           
        }
       
        if let imageData = homeModel.image {
            pageControl.numberOfPages = imageData.count
            if imageData.count > 0 {
                pageControl.isHidden = false
                self.imageHeiht.constant = 350
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
//    func getCategory(staus:Int) -> String {
////        switch staus {
////        case 4:
////            return "Answer"
////        case 2:
////            return "Social"
////        case 3:
////
//
////        }
//    }
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
                    if let value1 = data.like_count, value1 > 0 {
                        self.wishlistBtn.setTitle(" \(value1)", for: .normal)
                    }
                    if data.status == true {
                        self.wishlistBtn.setImage(UIImage(named: "fheart"), for: .normal)
                       
                    } else {
                        self.wishlistBtn.setImage(UIImage(named: "heart"), for: .normal)
 
                    }
                case .failure(_):
                    print("")
                }
            }

        }
        
    }
    @IBAction  func followClicked(_ sender: UIButton) {
        let request = ComplaintFollowRequest(posted_id: userPostedID)
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
extension UILabel {

    func setLineSpacing(lineSpacing: CGFloat = 1.5, lineHeightMultiple: CGFloat = 0.0) {

        guard let labelText = self.text else { return }

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple

        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }

        // (Swift 4.2 and above) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))


        // (Swift 4.1 and 4.0) Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        self.attributedText = attributedString
    }
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
             let readMoreText: String = trailingText + moreText

             let lengthForVisibleString: Int = self.vissibleTextLength
             let mutableString: String = self.text!
             let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
             let readMoreLength: Int = (readMoreText.count)
             let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
             let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font])
             let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
             answerAttributed.append(readMoreAttributed)
             self.attributedText = answerAttributed
         }

         var vissibleTextLength: Int {
             let font: UIFont = self.font
             let mode: NSLineBreakMode = self.lineBreakMode
             let labelWidth: CGFloat = self.frame.size.width
             let labelHeight: CGFloat = self.frame.size.height
             let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)

             let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
             let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
             let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)

             if boundingRect.size.height > labelHeight {
                 var index: Int = 0
                 var prev: Int = 0
                 let characterSet = CharacterSet.whitespacesAndNewlines
                 repeat {
                     prev = index
                     if mode == NSLineBreakMode.byCharWrapping {
                         index += 1
                     } else {
                         index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                     }
                 } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
                 return prev
             }
             return self.text!.count
         }
}
extension String {
    func convertToAttributedFromHTML() -> NSAttributedString? {
        var attributedText: NSAttributedString?
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue]
        if let data = data(using: .unicode, allowLossyConversion: true), let attrStr = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            attributedText = attrStr
        }
        return attributedText
    }
}
