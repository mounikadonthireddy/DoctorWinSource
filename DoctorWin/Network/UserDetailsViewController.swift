//
//  UserDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import UIKit

class UserDetailsViewController: ViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    var profileVM = UserDetailsViewModel()
    var userDetailsModel : ProfileDataModel?
    var newsArray: [NewsModel] = []
    var articelArray: [ArticalsDataModel] = []
    var casesArray: [CasesDataModel] = []
    var RequestUserID = ""
    var selectionType = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.register(UINib(nibName: "ProfileHeadCell", bundle: nil), forCellReuseIdentifier: "ProfileHeadCell")
        
        self.profileTableView.register(UINib(nibName: "UserHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        profileTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        profileTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        profileTableView.register(UINib(nibName: "ArticalCell", bundle: nil), forCellReuseIdentifier: "ArticalCell")
        
        self.navigationController?.isNavigationBarHidden = true
        profileTableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        profileVM.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        loadUserDetails()
        loadUserPostedNews()
        loadUserPostedCases()
        loadUserPostedCases()
        tabBarController?.tabBar.isHidden = false
    }
    func loadUserDetails() {
        self.showLoader()
        profileVM.getProfileData(userID: User.shared.userID, requestId: RequestUserID)
        
    }
    func loadUserPostedNews() {
        self.showLoader()
        profileVM.getUserPostedNews(userID: RequestUserID)
        
    }
    func loadUserPostedCases() {
        self.showLoader()
        profileVM.getUserPostedCases(userID: RequestUserID)
        
    }
    func loadUserPostedArticles() {
        self.showLoader()
        profileVM.getUserPostedArticles(userID: RequestUserID)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        //  tabBarController?.tabBar.isHidden = true
    }
}

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectionType {
        case 0:
        return newsArray.count
        case 1:
            return casesArray.count
        case 2:
            return newsArray.count
        case 3:
            return articelArray.count
        default:
            return 0
    }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectionType {
        case 0:
            let cell: NewsCell
                = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
            cell.configureData(homeModel: newsArray[indexPath.row])
            return cell
            
        case 1:
            let cell: CaseCell
                = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
           // cell.configureData(homeModel: newsArray[indexPath.row])
            return cell
            
        case 2:
            let cell: NewsCell
                = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
            cell.configureData(homeModel: newsArray[indexPath.row])
            return cell
            
        case 3:
            let cell: ArticalCell
                = tableView.dequeueReusableCell(withIdentifier: "ArticalCell") as! ArticalCell
         //   cell.configureData(homeModel: newsArray[indexPath.row])
            return cell
            
        default:
            
            return UITableViewCell()
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 400
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserHeaderView") as? UserHeaderView {
            if let userDetails = userDetailsModel {
                headerView.configureView(data: userDetails)
            }
            headerView.followBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
            headerView.viewBtn.addTarget(self, action: #selector(viewClicked(button:)), for: .touchUpInside)
            headerView.socialBtn.addTarget(self, action: #selector(socialClicked(button:)), for: .touchUpInside)
            headerView.casesBtn.addTarget(self, action: #selector(casesClicked(button:)), for: .touchUpInside)
            headerView.newsBtn.addTarget(self, action: #selector(newsClicked(button:)), for: .touchUpInside)
            headerView.articlesBtn.addTarget(self, action: #selector(articlesClicked(button:)), for: .touchUpInside)
            headerView.followCountBtn.addTarget(self, action: #selector(followCountClicked(button:)), for: .touchUpInside)
            headerView.followingCountBtn.addTarget(self, action: #selector(followingCountClicked(button:)), for: .touchUpInside)
            headerView.interfaceSegmented.delegate = self
            return headerView
        }
        
        return nil
        
    }
    @objc func casesClicked(button: UIButton) {
        self.selectionType = 1
        self.loadUserPostedCases()
    }
    @objc func newsClicked(button: UIButton) {
        self.loadUserPostedNews()
        self.selectionType = 2
    }
    @objc func articlesClicked(button: UIButton) {
        self.selectionType = 3
        self.loadUserPostedArticles()
    }
    @objc func socialClicked(button: UIButton) {
        self.selectionType = 0
        self.loadUserPostedArticles()
    }
    @objc func viewClicked(button: UIButton) {
        
    }
    @objc func followingCountClicked(button: UIButton) {
        
    }
    @objc func followCountClicked(button: UIButton) {
        
    }
    @objc func followClicked(button: UIButton) {
        
    }
}
extension UserDetailsViewController: UserDetailsViewModelDelegate {
    func didReciveProfileData(response: ProfileDataModel?, error: String?) {
        self.dismiss()
        if response != nil {
            userDetailsModel = response!
            profileTableView.reloadData()
        }
    }
    
    func didReceivePostedNews(response: [NewsModel]?, error: String?) {
        self.dismiss()
        if error == nil {
            newsArray = response ?? []
            profileTableView.reloadData()
        }
    }
    
    func didReceivePostedCases(response: [CasesDataModel]?, error: String?) {
        self.dismiss()
        if error == nil {
            casesArray = response ?? []
            profileTableView.reloadData()

        }
    }
    
    func didReceivePostedArticles(response: [ArticalsDataModel]?, error: String?) {
        self.dismiss()
        if error == nil {
            articelArray = response ?? []
            profileTableView.reloadData()

        }
    }
    
}

extension UserDetailsViewController : CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print(index)
        if index == 0 {
//            self.los()
        } else if index == 1 {
//            self.loadBookmarkNews()
        } else {
//            self.loadLikedNews()
        }
        
       
    }
}
