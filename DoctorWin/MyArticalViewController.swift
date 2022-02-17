//
//  MyArticalViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 20/01/22.
//

import UIKit

class MyArticalViewController: ViewController, ExpandableLabelDelegate {
  
    var states : Array<Bool>!

    var newsArray:[ArticalsDataModel] = []
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet{
            interfaceSegmented.setButtonTitles(buttonTitles: ["My Articles","Bookmark Articles", "Liked Articles"])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
        }
    }
    var newsVM = ArticalViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.register(UINib(nibName: "ArticalCell", bundle: nil), forCellReuseIdentifier: "ArticalCell")

        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.navigationItem.title = "News & Stories"
        self.navigationController?.isNavigationBarHidden = true
        newsVM.delegate = self
        interfaceSegmented.delegate = self
        // Do any additional setup after loading the view.
       
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.loadMyNews()
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

extension MyArticalViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ArticalCell
            = tableView.dequeueReusableCell(withIdentifier: "ArticalCell") as! ArticalCell
        cell.configureDataWith(homeModel: newsArray[indexPath.row])
        cell.descriptionLable.delegate = self
        
        cell.descriptionLable.setLessLinkWith(lessLink: "Close", attributes: [.foregroundColor:UIColor.red], position: .left)
        
        cell.layoutIfNeeded()
        
        cell.descriptionLable.shouldCollapse = true
        cell.descriptionLable.textReplacementType = .word
        cell.descriptionLable.numberOfLines = 5
        cell.descriptionLable.collapsed = states[indexPath.row]
        cell.descriptionLable.text = newsArray[indexPath.row].artical_discription
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
//        nextVC.newsDetailsData = newsArray[indexPath.row]
//        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
    
}
extension MyArticalViewController: ArticalViewModelDelegate {
    func didReceiveArtical(response: [ArticalsDataModel]?, error: String?) {
        self.dismiss()
        if (error != nil) {
            
        } else {
        self.newsArray = response ?? []
        self.newsTableView.reloadData()
            states = [Bool](repeating: true, count: newsArray.count)

        }
    }
    
    
}
extension MyArticalViewController: CustomSegmentedControlDelegate {
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
    @objc   func willExpandLabel(_ label: ExpandableLabel) {
        newsTableView.beginUpdates()
    }
    
    @objc  func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: newsTableView)
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
