//
//  NewsCategoryViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 10/02/22.
//

import UIKit

class NewsCategoryViewController: ViewController {

    var newsArray:[NewscategoryDataModel] = []
    @IBOutlet weak var newsTableView: UITableView!
    var newsVM = NewsViewModel()
    var pageId: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        newsVM.delegate = self
        self.parse()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
       
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        // tabBarController?.tabBar.isHidden = true
    }
    func parse() {
        self.showLoader()
        newsVM.getNews(userID: User.shared.userID,pageId: pageId)
    }
    @IBAction func backClikced(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NewsCategoryViewController : UITableViewDelegate, UITableViewDataSource {
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
//        nextVC.newsDetailsData1 = newsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension NewsCategoryViewController: NewsViewModelDelegate {
    func didReceiveNews(response: [NewsDataModel]?, error: String?) {
        
    }
    
    func didReceivePageNews(response: [NewscategoryDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
            self.newsArray = response ?? []
            self.newsTableView.reloadData()
        }

    }
    
    
    func didReceiveNewsCategory(response: [NewsCategoryModel]?, error: String?) {
        //
    }
    
   
}
