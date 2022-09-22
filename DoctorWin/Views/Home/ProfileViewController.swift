//
//  ProfileViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 14/04/22.
//

import UIKit

class ProfileViewController: ViewController,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var profileTableView: UITableView!
    var userDetailsModel : ProfileDataModel?
    var userVM = UserDetailsViewModel()
    var newsArray: [NewsModel] = []
    var postsArray:[HomeDataModel] = []
    var casesArray: [CasesDataModel] = []
    var questionsArray : [PostedQuestionModel] = []
    var answersArray: [AnswersModel] = []
    var profileDataModel : ProfileDataModel!
    var profileVM = ProfileViewModel()
    var selectionType = -1
    override func viewDidLoad() {
        super.viewDidLoad()
       
        profileTableView.register(ProfileViewHeader.nib, forHeaderFooterViewReuseIdentifier: ProfileViewHeader.identifier)
        
        profileTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        profileTableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        
        profileTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        profileTableView.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACell")
        profileTableView.register(UINib(nibName: "UserAnswerCell", bundle: nil), forCellReuseIdentifier: "UserAnswerCell")
        self.navigationController?.isNavigationBarHidden = true
        userVM.delegate = self
        self.loadPostsData()
        parse()

    }
    func parse() {
        self.showLoader()
        userVM.getProfileData(userID: User.shared.userID)
        
    }
    func loadPostsData() {
        self.showLoader()
        userVM.getPostData(userID: User.shared.userID)
    }
    func loadCasesData() {
        self.showLoader()
        userVM.getCasesData(userID: User.shared.userID)
    }
    func loadQuestionsData() {
        self.showLoader()
        userVM.getQuestionsData(userID: User.shared.userID)
    }
    func loadAnswersData() {
        self.showLoader()
        userVM.getAnswersData(userID: User.shared.userID)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.tabBar.isHidden = false
    }
    
}
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
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
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileViewHeader.identifier) as? ProfileViewHeader {
            if  profileDataModel != nil  {
                headerView.configureView(data: profileDataModel)
                headerView.viewBtn.addTarget(self, action: #selector(viewClicked(button:)), for: .touchUpInside)
                headerView.followBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
                headerView.followingBtn.addTarget(self, action: #selector(followingClicked(button:)), for: .touchUpInside)
                headerView.mcqBtn.addTarget(self, action: #selector(mcqsClicked(button:)), for: .touchUpInside)
                headerView.resumeBtn.addTarget(self, action: #selector(resumeClicked(button:)), for: .touchUpInside)
                headerView.bookmarkBtn.addTarget(self, action: #selector(bookmarkClicked(button:)), for: .touchUpInside)
            }
            headerView.interfaceSegmented.delegate  = self
            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 390
    }
}

extension ProfileViewController  {
    @objc func viewClicked(button: Any) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "MeViewController") as! MeViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func followClicked(button: Any) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowViewController") as! FollowViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc func followingClicked(button: Any) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func bookmarkClicked(button: Any) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "BookmarksViewController") as! BookmarksViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func resumeClicked(button: Any) {
    }
    @objc func mcqsClicked(button: Any) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "MCQViewController") as! MCQViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}


struct ProfileModel {
    let name: String
    let imageName: String
}

extension ProfileViewController: UserDetailsViewModelDelegate {
    func didReciveProfileData(response: ProfileDataModel?, error: String?) {
        self.dismiss()
        profileDataModel = response
        profileTableView.reloadData()
    }
    
    func didReciveGroupProfileData(response: GroupProfileModel?, error: String?) {
        
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
    
}
extension ProfileViewController : CustomSegmentedControlDelegate {
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
