//
//  UserDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import UIKit

class UserDetailsViewController: ViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    var userVM = UserDetailsViewModel()
    var userDetailsModel : ProfileDataModel?
    var groupModel : GroupProfileModel?
    var newsArray: [NewsModel] = []
    var postsArray:[HomeDataModel] = []
    var casesArray: [CasesDataModel] = []
    var questionsArray : [PostedQuestionModel] = []
    var answersArray: [AnswersModel] = []
    var requestUserID = ""
    var groupId = ""
    var selectionType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileTableView.register(UINib(nibName: "UserHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        profileTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        profileTableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        
        profileTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
       
        profileTableView.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACell")
        profileTableView.register(UINib(nibName: "UserAnswerCell", bundle: nil), forCellReuseIdentifier: "UserAnswerCell")
        
        
        
        self.navigationController?.isNavigationBarHidden = true
        profileTableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: 0, right: 0)
        userVM.delegate = self
        
        self.loadPostsData()
        self.loadGroupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true
    }
    
    func loadHomeData() {
        
    }
    func loadGroupData() {
        self.showLoader()
        if groupId != "" {
            userVM.getGroupProfileData(userID: User.shared.userID, groupId: groupId)
        } else if requestUserID != "" {
            userVM.getProfileData(userID: requestUserID)
        } else {
            userVM.getProfileData(userID: User.shared.userID)
        }
    }
    func loadPostsData() {
        self.showLoader()
        if groupId != "" {
            userVM.getPostData(userID: User.shared.userID, group_id: groupId)
        } else if groupId == "" && requestUserID != "" {
            userVM.getPostData(userID: requestUserID)
        } else {
            userVM.getPostData(userID: User.shared.userID)
        }
    }
    func loadCasesData() {
        self.showLoader()
        if groupId != "" {
            userVM.getCasesData(userID: User.shared.userID, group_id: groupId)
        } else if groupId == "" && requestUserID != "" {
            userVM.getCasesData(userID: requestUserID)
        } else {
            userVM.getCasesData(userID: User.shared.userID)
        }
    }
    func loadQuestionsData() {
        self.showLoader()
        if groupId != "" {
            userVM.getQuestionsData(userID: User.shared.userID, group_id: groupId)
        } else if groupId == "" && requestUserID != "" {
            userVM.getQuestionsData(userID: requestUserID)
        } else {
            userVM.getQuestionsData(userID: User.shared.userID)
        }
    }
    func loadAnswersData() {
        self.showLoader()
        if groupId != "" {
            userVM.getAnswersData(userID: User.shared.userID, group_id: groupId)
        } else if groupId == "" && requestUserID != "" {
            userVM.getAnswersData(userID: requestUserID)
        } else {
            userVM.getQuestionsData(userID: User.shared.userID)
        }
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
        case -1:
            return 0
        case 0:
            return postsArray.count
        case 1:
            return casesArray.count
        case 2:
            return questionsArray.count
        case 3:
            return answersArray.count
            
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectionType {
        case 0:
            let cell: CaseCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
            cell.configureData(homeModel: postsArray[indexPath.row])
            return cell
            
        case 1:
            let cell: CaseCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
            cell.configureDataWith(homeModel: casesArray[indexPath.row])
            return cell
            
        case 2:
            let cell: QACell
            = tableView.dequeueReusableCell(withIdentifier: "QACell") as! QACell
            cell.configureWith(data: questionsArray[indexPath.row])
            return cell
            
        case 3:
            let cell: UserAnswerCell
            = tableView.dequeueReusableCell(withIdentifier: "UserAnswerCell") as! UserAnswerCell
            cell.configureDataWith(homeModel: answersArray[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
        }
    }
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let details = groupModel {
            if details.join_status == true {
                return 420
            }
        }
        return 350
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserHeaderView") as? UserHeaderView {
            if let userDetails = userDetailsModel {
                headerView.configureView(data: userDetails)
                if userDetails.followStatus == true {
                    headerView.joinBtn.setTitle("Following", for: .normal)
                } else {
                    headerView.joinBtn.setTitle("Follow", for: .normal)
                }
                headerView.joinBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
               
            }
            if let details = groupModel {
                headerView.configureView(data: details)
                if details.join_status == true {
                headerView.joinBtn.setTitle("Joined", for: .normal)
                } else {
                    headerView.joinBtn.setTitle("Join", for: .normal)
                }
                headerView.joinBtn.addTarget(self, action: #selector(joinClicked(button:)), for: .touchUpInside)
            }
            headerView.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            headerView.followBtn.addTarget(self, action: #selector(followCountClicked(button:)), for: .touchUpInside)
            headerView.postBtn.addTarget(self, action: #selector(postClicked(button:)), for: .touchUpInside)
            //            headerView.followCountBtn.addTarget(self, action: #selector(followCountClicked(button:)), for: .touchUpInside)
            //            headerView.followingCountBtn.addTarget(self, action: #selector(followingCountClicked(button:)), for: .touchUpInside)
            headerView.interfaceSegmented.delegate = self
            return headerView
        }
        
        return nil
        
    }
    @objc func backClicked(button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func postClicked(button: UIButton) {
        let str = UIStoryboard(name: "Add", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "AddMainViewController") as! AddMainViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func followingCountClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func followCountClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowViewController") as! FollowViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
  
    @objc func followClicked(button: UIButton) {
        if let userDetails = userDetailsModel {
            self.showLoader()
            let request = FollowRequest(follow_id: userDetails.dworks_id ?? "", dworks_id: User.shared.userID)
       
        let resource = ProfileEditResource()
        resource.followPerson(request: request) { result in
            DispatchQueue.main.async {
                self.dismiss()
                switch result {
                case .success(let data):
                    if data != nil && data == true {
                        self.loadGroupData()
                        self.profileTableView.reloadData()
                    }
                case .failure(_):
                    print("")
                }
                
            }
            
        }
        }
    }
    @objc func joinClicked(button: UIButton) {
        
    }
}
extension UserDetailsViewController: UserDetailsViewModelDelegate {
    func didReciveGroupProfileData(response: GroupProfileModel?, error: String?) {
        self.dismiss()
        if response != nil {
            groupModel = response!
        }
        self.profileTableView.reloadData()
    }
    
    func didRecivePostsData(response: [HomeDataModel]?, error: String?) {
        self.dismiss()
        postsArray = response ?? []
        self.profileTableView.reloadData()
    }
    
    func didReciveCasesData(response: [CasesDataModel]?, error: String?) {
        self.dismiss()
        casesArray  = response ?? []
        self.profileTableView.reloadData()
    }
    
    func didReciveQuestionsData(response: [PostedQuestionModel]?, error: String?) {
        self.dismiss()
        questionsArray  = response ?? []
        self.profileTableView.reloadData()
    }
    
    func didReciveAnswersData(response: [AnswersModel]?, error: String?) {
        self.dismiss()
        answersArray = response ?? []
        self.profileTableView.reloadData()
    }
    
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
            nextVC.caseId = casesArray[indexPath.row].id
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
        switch index {
            
        case 0:
            self.selectionType = 0
            self.loadPostsData()
            
        case 1:
            self.selectionType = 1
            self.loadCasesData()
            
        case 2:
            self.selectionType = 2
            self.loadQuestionsData()
        case 3:
            self.selectionType = 3
            self.loadAnswersData()
            
        default: break
        }
        
    }
}
