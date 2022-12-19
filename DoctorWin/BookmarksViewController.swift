//
//  BookmarksViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit

class BookmarksViewController: ViewController, ExpandableLabelDelegate {
   
    @IBOutlet weak var bookmarksTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["Jobs","Cases",  "News", "Social","Answers"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    var states : Array<Bool>!
    var bookmarkVM = BookMarkViewModel()
    var selectedIndex = 0
    var jobsArray : [JobModel] = []
    var socialArray: [HomeDataModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interfaceSegmented.delegate = self
        bookmarkVM.delegate = self
        
        bookmarksTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        bookmarksTableView.register(UINib.init(nibName: "CarrierJobCell", bundle: nil), forCellReuseIdentifier: "CarrierJobCell")
        
        
        bookmarksTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        // Do any additional setup after loading the view.
        self.loadBookmarks(display_status: 1, page: 1)
    }
    func loadBookmarkJobs() {
        //bookmarkVM.getBookMarkedJobs(userID: User.shared.userID)
    }
    func loadBookmarks(display_status: Int, page: Int) {
        self.showLoader()
        bookmarkVM.getBookmarkSocail(display_status: display_status, page: page)
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
        case 1,3,2,4:
            return socialArray.count
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
            
        case 1,3,4:
            let cell: CaseCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
            cell.configureData(homeModel: socialArray[indexPath.row])
            return cell
            
            
        case 2:
            let cell: NewsCell
            = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
            cell.configureData(homeModel: socialArray[indexPath.row])
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
            self.loadBookmarks(display_status: 1, page: 1)
        } else if index == 2 {
            self.loadBookmarks(display_status: 5, page: 1)
        } else if index == 3 {
            self.loadBookmarks(display_status: 2, page: 1)
        } else if index == 4 {
            self.loadBookmarks(display_status: 1, page: 1)
        }
        
        self.showLoader()
    }
}
extension BookmarksViewController: BookMarkDelegate {
    func didReceiveBookmakedJobs(response: [JobModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
            self.jobsArray = response ?? []
            self.bookmarksTableView.reloadData()
        }
        
    }
    func didReceiveBookmakedSocail(response: HomeResponseModel?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
            self.socialArray = response?.homeResponse ?? []
            self.bookmarksTableView.reloadData()
        }
    }
    
}
