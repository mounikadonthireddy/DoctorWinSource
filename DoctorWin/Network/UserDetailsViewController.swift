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
   
    var casesArray: [CasesDataModel] = []
    var RequestUserID = ""
    var selectionType = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.profileTableView.register(UINib(nibName: "UserHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        profileTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        profileTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
     
        
        self.navigationController?.isNavigationBarHidden = true
        profileTableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        profileVM.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
      //  loadUserDetails()
//        loadUserPostedNews()
//        loadUserPostedCases()
//        loadUserPostedCases()
        tabBarController?.tabBar.isHidden = true
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
            cell.configureDataWith(homeModel: casesArray[indexPath.row])
            return cell
            
        case 2:
            let cell: NewsCell
                = tableView.dequeueReusableCell(withIdentifier: "NewsCell") as! NewsCell
            cell.configureData(homeModel: newsArray[indexPath.row])
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
            headerView.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            headerView.followBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
            headerView.viewBtn.addTarget(self, action: #selector(viewClicked(button:)), for: .touchUpInside)
            headerView.followCountBtn.addTarget(self, action: #selector(followCountClicked(button:)), for: .touchUpInside)
            headerView.followingCountBtn.addTarget(self, action: #selector(followingCountClicked(button:)), for: .touchUpInside)
            headerView.interfaceSegmented.delegate = self
            return headerView
        }
        
        return nil
        
    }
    @objc func backClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectionType {
        case 1:
            let str = UIStoryboard(name: "Details", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "CaseDetailsViewController") as! CaseDetailsViewController
            nextVC.caseId = casesArray[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            let str = UIStoryboard(name: "Details", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
          
            self.navigationController?.pushViewController(nextVC, animated: true)
        
        default:
            let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ExamDetailsViewController") as! ExamDetailsViewController
            //nextVC.detailsModel = homedataArry[indexPath.row]
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension UserDetailsViewController : CustomSegmentedControlDelegate {
    func change(to index: Int) {
        print(index)
        switch index {
        case 1:
            self.selectionType = 1
            self.loadUserPostedCases()
            
        case 2:
            self.loadUserPostedNews()
            self.selectionType = 2
            
        
            
        default: break
        }
       
    }
}
