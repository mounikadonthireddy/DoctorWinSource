//
//  NewsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class NewsViewController: ViewController {
    var newsArray:[NewsDataModel] = []
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    var newsTypeArray:[NewsCategoryModel] = []
    
    var newsVM = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
        newsVM.delegate = self
        // Do any additional setup after loading the view.
        
        newsCollectionView.register(UINib.init(nibName: "NewTypeCell", bundle: nil), forCellWithReuseIdentifier: "NewTypeCell")
        self.newsCollectionView.delegate = self
        self.newsCollectionView.dataSource = self
        self.newsCollectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        //        newsCollectionView.collectionViewLayout.invalidateLayout()
       // newsCollectionView.frame.size = size
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.parse()
        self.getNewsCategory()
        tabBarController?.tabBar.isHidden = false
        self.newsCollectionView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        // tabBarController?.tabBar.isHidden = true
    }
    func parse() {
        self.showLoader()
        newsVM.getNews(userID: User.shared.userID)
    }
    func getNewsCategory() {
        self.showLoader()
        newsVM.getNewsCategory()
    }
}

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsCell
        = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
        cell.configureCell(with: newsArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        nextVC.newsDetailsData = newsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension NewsViewController: NewsViewModelDelegate {
    func didReceiveNewsCategory(response: [NewsCategoryModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
            self.newsTypeArray = response ?? []
            self.newsCollectionView.reloadData()
        }
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
extension NewsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTypeCell", for: indexPath) as! NewTypeCell
        
        if let urlString = newsTypeArray[indexPath.row].image {
            let finalUrlString = ApiEndpoints.baseImageURL + urlString
            
            cell.newsImage.sd_setImage(with: URL(string: finalUrlString), placeholderImage: UIImage(named: "loginBg"))
        }
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: 100, height: 100)
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsCategoryViewController") as! NewsCategoryViewController
       // nextVC.newsDetailsData = newsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
