//
//  MyNewsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class MyNewsViewController: ViewController,ExpandableLabelDelegate {
    var states : Array<Bool>!
    var newsArray:[NewsModel] = []
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["My News","Bookmark News", "Likes News"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    var newsVM = NewsDataViewModel()

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
        self.loadMyNews(index: 0)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
       // tabBarController?.tabBar.isHidden = true
    }
    
    func loadMyNews(index: Int) {
        self.showLoader()
        self.newsVM.getNews(userID: User.shared.userID, index: index)
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
     let point = label.convert(CGPoint.zero, to: newsTableView)
//        if let indexPath = bookmarksTableView.indexPathForRow(at: point) as IndexPath? {
//            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ArticalDetailsViewController") as! ArticalDetailsViewController
//            //nextVC.articalDetails = articlesArray[indexPath.row]
//            self.navigationController?.pushViewController(nextVC, animated: true)
//        }
        
        if let indexPath = newsTableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = false
            DispatchQueue.main.async { [weak self] in
                self?.newsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        newsTableView.endUpdates()
    }
    
    @objc func willCollapseLabel(_ label: ExpandableLabel) {
        newsTableView.beginUpdates()
    }
    
    @objc  func didCollapseLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: newsTableView)
        if let indexPath = newsTableView.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.newsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        newsTableView.endUpdates()
    }
}

extension MyNewsViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        self.newsVM.getNews(userID: User.shared.userID, index: index)
    }
    
    
}
extension MyNewsViewController: NewsBookMarkDelegate {
    func didReceiveBookmakedNews(response: [NewsModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.newsArray = response ?? []
        states = [Bool](repeating: true, count: newsArray.count)
        self.newsTableView.reloadData()
        }
    }
    
    
}
