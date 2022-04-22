//
//  MyNewsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class MyNewsViewController: ViewController {

    var newsArray:[NewsDataModel] = []
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["My News","Bookmark News", "Likes News"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    var newsVM = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")

        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.navigationItem.title = "News & Stories"
        self.navigationController?.isNavigationBarHidden = true
        newsVM.delegate = self
        interfaceSegmented.delegate = self
        // Do any additional setup after loading the view.
        self.loadMyNews()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
       // tabBarController?.tabBar.isHidden = true
    }
    func loadMyNews() {
        newsVM.getMyNews(userID: User.shared.userID)
    }
    func loadBookmarkNews() {
        newsVM.getBookmarkNews(userID: User.shared.userID)
    }
    func loadLikedNews() {
        newsVM.getLikedNews(userID: User.shared.userID)
    }
    
   
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyNewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell
            = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
     //   cell.configureCell(with: newsArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
//        nextVC.newsDetailsData = newsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}
extension MyNewsViewController: NewsViewModelDelegate {
    func didReceivePageNews(response: [NewscategoryDataModel]?, error: String?) {
        
    }
    
    func didReceiveNewsCategory(response: [NewsCategoryModel]?, error: String?) {
        //
    }
    
    func didReceiveNews(response: [NewsDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.newsArray = response ?? []
        self.newsTableView.reloadData()
        }
    }
    
    
}
extension MyNewsViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print(index)
        if index == 0 {
            self.loadMyNews()
        } else if index == 1 {
            self.loadBookmarkNews()
        } else {
            self.loadLikedNews()
        }
        
        self.showLoader()
    }
    
    
}
