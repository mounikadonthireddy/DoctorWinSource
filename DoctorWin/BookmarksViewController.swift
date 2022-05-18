//
//  BookmarksViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit

class BookmarksViewController: ViewController {
    var newsArray:[NewsDataModel] = []
    var articlesArray:[ArticalsDataModel] = []
    var states : Array<Bool>!
    var homedataArry: [HomeDataModel] = []
    var homeVM = HomeViewModel()

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

        articlesVM.delegate = self
        newsVM.delegate = self
//        homeVM.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func loadBookmarkNews() {
        newsVM.getBookmarkNews(userID: User.shared.userID)
    }
    func loadBookmarkArticles() {
        articlesVM.getBookmarkNews(userID: User.shared.userID)
    }
    func loadBookmarkCases() {
        homeVM.getBookmarkCases(userID: User.shared.userID)
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
extension BookmarksViewController: NewsViewModelDelegate {
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
        self.bookmarksTableView.reloadData()
        }
    }
    
    
}
extension BookmarksViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print(index)
        if index == 0 {
            //self.loadMyNews()
        } else if index == 1 {
           //} self.loadBookmarkNews()
        } else {
           // self.loadLikedNews()
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
    
    func didReceiveLoginResponse(response: [HomeDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.homedataArry = response ?? []
        self.bookmarksTableView.reloadData()
        }
}
}
