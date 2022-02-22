//
//  MyPollsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/01/22.
//

import UIKit

class MyPollsViewController: ViewController {
    
    var newsArray:[PollsDataModel] = []
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["My Polls","Bookmark Polls", "Liked Polls"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    var newsVM = PollsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "PollTableViewCell", bundle: nil), forCellReuseIdentifier: "PollTableViewCell")

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
        newsVM.getMyPolls(userID: User.shared.userID)
    }
    func loadBookmarkNews() {
        newsVM.getBookmarkPolls(userID: User.shared.userID)
    }
    func loadLikedNews() {
        newsVM.getLikedPolls(userID: User.shared.userID)
    }
    
   
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MyPollsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PollTableViewCell
            = tableView.dequeueReusableCell(withIdentifier: "PollTableViewCell") as! PollTableViewCell
        cell.configureData(homeModel: newsArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
//        nextVC.newsDetailsData = newsArray[indexPath.row]
//        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}
extension MyPollsViewController: PollsViewModelDelegate {
    func didReceiveNews(response: [PollsDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.newsArray = response ?? []
        self.newsTableView.reloadData()
        }
    }
    
    
}
extension MyPollsViewController: CustomSegmentedControlDelegate {
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
