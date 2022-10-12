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
    var socialArray: [HomeDataModel] = []
    var casesArray: [CasesDataModel] = []
    var answersArray: [AnswersModel] = []
    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Jobs","Cases",  "News", "Social","Answers"])
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
        bookmarksTableView.register(UINib(nibName: "UserAnswerCell", bundle: nil), forCellReuseIdentifier: "UserAnswerCell")
   
        // Do any additional setup after loading the view.
        self.loadBookmarkJobs()
    }
    
    func loadBookmarkNews() {
        bookmarkVM.getBookmarkNews(userID: User.shared.userID)
    }
    func loadBookmarkSocial() {
        bookmarkVM.getBookmarkSocail(userID: User.shared.userID)
    }
    func loadBookmarkCases() {
        bookmarkVM.getBookmarkCases(userID: User.shared.userID)
    }
    func loadBookmarkJobs() {
        bookmarkVM.getBookMarkedJobs(userID: User.shared.userID)
    }
    func loadBookmarkAnswers() {
        bookmarkVM.getBookMarkedJAnswers(userID: User.shared.userID)
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
            return newsArray.count
        case 3:
            return socialArray.count
        case 4:
            return answersArray.count
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
            let cell: NewsCell
                = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
           cell.configureData(homeModel: newsArray[indexPath.row])
            return cell
        case 3:
            let cell: CaseCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
            cell.configureData(homeModel: socialArray[indexPath.row])
         
            return cell
        case 4:
            let cell: UserAnswerCell
            = tableView.dequeueReusableCell(withIdentifier: "UserAnswerCell") as! UserAnswerCell
            cell.configureDataWith(homeModel: answersArray[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
//        nextVC.newsDetailsData = newsArray[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc   func willExpandLabel(_ label: ExpandableLabel) {
       // tableView.beginUpdates()
    }
    
    @objc  func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: bookmarksTableView)
        if let indexPath = bookmarksTableView.indexPathForRow(at: point) as IndexPath? {
           
           
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
            self.loadBookmarkNews()
        } else if index == 3 {
            self.loadBookmarkSocial()
        } else if index == 4 {
            self.loadBookmarkAnswers()
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
    func didReceiveBookmakedSocail(response: [HomeDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.socialArray = response ?? []
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
    func didReceiveBookmakedAnswers(response: [AnswersModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.answersArray = response ?? []
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
}
