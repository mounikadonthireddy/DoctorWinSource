//
//  BookmarksViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit

class BookmarksViewController: ViewController {
   
    var states : Array<Bool>!
    var homeVM = HomeViewModel()
    var selectedIndex = -1
    var jobsArray : [JobsViewModel] = []
    var newsArray:[NewsDataModel] = []
    var articlesArray:[ArticalsDataModel] = []
    var casesArray: [HomeDataModel] = []
    var classifieldArray: [HomeDataModel] = []
    

    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Jobs","Cases", "Articles", "News", "Classified"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    var articlesVM = ArticalViewModel()
    var newsVM = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        interfaceSegmented.delegate = self
        articlesVM.delegate = self
        newsVM.delegate = self
        bookmarksTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        bookmarksTableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")

        bookmarksTableView.register(UINib(nibName: "ArticalCell", bundle: nil), forCellReuseIdentifier: "ArticalCell")

        bookmarksTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    homeVM.delegate = self
        // Do any additional setup after loading the view.
//        loadBookmarkNews()
//        loadBookmarkArticles()
    }
    
    func loadBookmarkNews() {
        newsVM.getBookmarkNews(userID: User.shared.userID)
    }
    func loadBookmarkArticles() {
        articlesVM.getBookmarkArticles(userID: User.shared.userID)
    }
    func loadBookmarkCases() {
        homeVM.getBookmarkCases(userID: User.shared.userID)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BookmarksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedIndex {
        case 0:
            return jobsArray.count
        case 1:
            return casesArray.count
        case 2:
            return articlesArray.count
        case 3:
            return newsArray.count
        case 4:
            return classifieldArray.count
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedIndex {
        case 0:
            let cell: CarrierJobCell
                = tableView.dequeueReusableCell(withIdentifier: "CarrierJobCell") as! CarrierJobCell
         //   cell.configureCell(with: newsArray[indexPath.row])
            return cell
            
        case 1:
            let cell: CaseCell
                = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
         //   cell.configureCell(with: newsArray[indexPath.row])
            return cell
            
        case 2:
            let cell: ArticalCell
                = tableView.dequeueReusableCell(withIdentifier: "ArticalCell") as! ArticalCell
            cell.configureDataWith(homeModel: articlesArray[indexPath.row])
            return cell
            
        case 3:
            let cell: NewsCell
                = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
         //   cell.configureCell(with: newsArray[indexPath.row])
            return cell
            
        case 4:
            let cell: NewsCell
                = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
         //   cell.configureCell(with: newsArray[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
//        nextVC.newsDetailsData = newsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}
extension BookmarksViewController: NewsViewModelDelegate {
    func didReceivePageNews(response: [NewscategoryDataModel]?, error: String?) {
        self.dismiss()
    }
    
    func didReceiveNewsCategory(response: [NewsCategoryModel]?, error: String?) {
        self.dismiss()
        //
    }
    
    func didReceiveNews(response: [NewsDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.newsArray = response ?? []
        self.bookmarksTableView.reloadData()
        }
    }
    
    
}
extension BookmarksViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print(index)
        selectedIndex = index
        if index == 0 {
            //self.loadMyNews()
        } else if index == 1 {
            self.loadBookmarkCases()
        } else if index == 2 {
            self.loadBookmarkArticles()
        } else if index == 3 {
            self.loadBookmarkNews()
        } else {
            //self.loadLikedNews()
        }
        
        self.showLoader()
    }
    
    
}

extension BookmarksViewController: ArticalViewModelDelegate {
    func didReceiveArtical(response: [ArticalsDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.articlesArray = response ?? []
        self.bookmarksTableView.reloadData()
            states = [Bool](repeating: true, count: newsArray.count)

        }
    }
}
extension BookmarksViewController: HomeViewModelDelegate  {
    func didReciveHomeData(response: [HomeDataModel]?, error: String?) {
        self.dismiss()
    }
    
    
}
