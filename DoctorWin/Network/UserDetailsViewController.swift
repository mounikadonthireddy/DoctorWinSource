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
    var newsArray: [NewsModel] = []
    var postsArray:[HomeDataModel] = []
    var casesArray: [CasesDataModel] = []
    var questionsArray : [PostedQuestionModel] = []
    var answersArray: [AnswersModel] = []
    var RequestUserID = ""
    var groupId = "DWG10001"
    var selectionType = -1
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = true
    }
    
    func loadHomeData() {
        
    }
    func loadPostsData() {
        self.showLoader()
        userVM.getPostData(userID: User.shared.userID, group_id: groupId)
    }
    func loadCasesData() {
        self.showLoader()
        userVM.getCasesData(userID: User.shared.userID, group_id: groupId)
    }
    func loadQuestionsData() {
        self.showLoader()
        userVM.getQuestionsData(userID: User.shared.userID, group_id: groupId)
    }
    func loadAnswersData() {
        self.showLoader()
        userVM.getAnswersData(userID: User.shared.userID, group_id: groupId)
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
        
        return 355
        
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
//            headerView.viewBtn.addTarget(self, action: #selector(viewClicked(button:)), for: .touchUpInside)
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
