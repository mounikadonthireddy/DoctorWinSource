//
//  BookmarksViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit

class BookmarksViewController: ViewController, ExpandableLabelDelegate {
    var states : Array<Bool>!
    var bookmarkVM = BookMarkViewModel()
    var selectedIndex = 0
    var jobsArray : [CarrierModel] = []
    var newsArray:[NewsModel] = []
    var articlesArray:[ArticalsDataModel] = []
    var casesArray: [CasesDataModel] = []
    var classifieldArray: [HomeDataModel] = []
    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Jobs","Cases", "Articles", "News", "Classified"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        interfaceSegmented.delegate = self
       
        bookmarkVM.delegate = self
      
        bookmarksTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        bookmarksTableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")

        bookmarksTableView.register(UINib(nibName: "ArticalCell", bundle: nil), forCellReuseIdentifier: "ArticalCell")

        bookmarksTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
   
        // Do any additional setup after loading the view.
        self.loadBookmarkJobs()
    }
    
    func loadBookmarkNews() {
        bookmarkVM.getBookmarkNews(userID: User.shared.userID)
    }
    func loadBookmarkArticles() {
        bookmarkVM.getBookmarkArticles(userID: User.shared.userID)
    }
    func loadBookmarkCases() {
        bookmarkVM.getBookmarkCases(userID: User.shared.userID)
    }
    func loadBookmarkJobs() {
        bookmarkVM.getBookMarkedJobs(userID: User.shared.userID)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
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
            cell.configureCell(with: jobsArray[indexPath.row])
            return cell
            
        case 1:
            let cell: CaseCell
                = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
            cell.configureDataWith(homeModel: casesArray[indexPath.row])
            return cell
            
        case 2:
            let cell: ArticalCell
                = tableView.dequeueReusableCell(withIdentifier: "ArticalCell") as! ArticalCell
            cell.configureDataWith(homeModel: articlesArray[indexPath.row])
            cell.descriptionLable.delegate = self
            cell.descriptionLable.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .left)
            cell.layoutIfNeeded()
            cell.descriptionLable.shouldCollapse = true
            cell.descriptionLable.textReplacementType = .word
            cell.descriptionLable.numberOfLines = 5
            cell.descriptionLable.collapsed = states[indexPath.row]
            cell.descriptionLable.text = articlesArray[indexPath.row].discription
            return cell
            
        case 3:
            let cell: NewsCell
                = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
           cell.configureData(homeModel: newsArray[indexPath.row])
            cell.descriptionLable.delegate = self
            cell.descriptionLable.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .left)
            cell.layoutIfNeeded()
            cell.descriptionLable.shouldCollapse = true
            cell.descriptionLable.textReplacementType = .word
            cell.descriptionLable.numberOfLines = 5
            cell.descriptionLable.collapsed = states[indexPath.row]
            cell.descriptionLable.text = newsArray[indexPath.row].discription
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
    @objc   func willExpandLabel(_ label: ExpandableLabel) {
       // tableView.beginUpdates()
    }
    
    @objc  func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: bookmarksTableView)
        if let indexPath = bookmarksTableView.indexPathForRow(at: point) as IndexPath? {
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticalDetailsViewController") as! ArticalDetailsViewController
            //nextVC.articalDetails = articlesArray[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
//        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
//            states[indexPath.row] = false
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//        }
//        tableView.endUpdates()
    }
    
    @objc func willCollapseLabel(_ label: ExpandableLabel) {
       // tableView.beginUpdates()
    }
    
    @objc  func didCollapseLabel(_ label: ExpandableLabel) {
//        let point = label.convert(CGPoint.zero, to: tableView)
//        if let indexPath = tableView.indexPathForRow(at: point) as IndexPath? {
//            states[indexPath.row] = true
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//            }
//        }
//        tableView.endUpdates()
    }
    
    
}

extension BookmarksViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print(index)
        selectedIndex = index
        if index == 0 {
            self.loadBookmarkJobs()
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
extension BookmarksViewController: BookMarkDelegate {
    func didReceiveBookmakedJobs(response: [CarrierModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.jobsArray = response ?? []
        self.bookmarksTableView.reloadData()
        }
        
    }
    func didReceiveBookmakedCases(response: [CasesDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.casesArray = response ?? []
        self.bookmarksTableView.reloadData()
        }
    }
    
    func didReceiveBookmakedNews(response: [NewsModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.newsArray = response ?? []
            states = [Bool](repeating: true, count: newsArray.count)
        self.bookmarksTableView.reloadData()
        }
    }
    
    func didReceiveBookmakedArticles(response: [ArticalsDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.articlesArray = response ?? []
        self.bookmarksTableView.reloadData()
            states = [Bool](repeating: true, count: articlesArray.count)

        }
    }
    
    func didReceiveBookmakedClassicfield(response: [CarrierModel]?, error: String?) {
        self.dismiss()
    }

    
}
