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
    @IBOutlet weak var postDescription: UILabel!
    @IBOutlet weak var wishlistBtn: UIButton!
    @IBOutlet weak var bookmarkBtn: UIButton!
    var newsDetailsData: NewsDataModel?
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
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    @IBAction func backClikced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
