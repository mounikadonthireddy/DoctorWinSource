//
//  NewsDetailsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postedPersonName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postDescription: UITextView!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var bookmarkBtn: UIButton!
    var newsDetailsData: NewsDataModel?
    var newsDetailsData1: NewscategoryDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "News & Stories"
        self.navigationItem.backButtonTitle = ""
        
        if let data = newsDetailsData {
            self.postTitle.text = data.artical_title
            self.postedPersonName.text = data.username
            self.postDescription.text = data.artical_discription
            
            if let urlString = data.artical_image {
                let finalUrlString = ApiEndpoints.baseImageURL + urlString
                self.postImageView.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
                
            }
            if data.like_status ?? false {
                self.wishlistBtn.setImage(UIImage(named: "fheart"), for: .normal)
            }
            if data.bookmark_status ?? false {
                self.bookmarkBtn.setImage(UIImage(named: "fbookmark"), for: .normal)
            }
        }
        if let data1 = newsDetailsData1 {
            self.postTitle.text = data1.title
            self.postedPersonName.text = data1.username
            self.postDescription.text = data1.news
            
            if let urlString = data1.image {
                let finalUrlString = ApiEndpoints.baseImageURL + urlString
                self.postImageView.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
                
            }
            if data1.like_status ?? false {
                self.wishlistBtn.setImage(UIImage(named: "fheart"), for: .normal)
            }
            if data1.bookmark_status ?? false {
                self.bookmarkBtn.setImage(UIImage(named: "fbookmark"), for: .normal)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    @IBAction func backClikced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
