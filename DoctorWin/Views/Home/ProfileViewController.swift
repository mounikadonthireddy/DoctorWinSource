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
    var postsArray:[HomeDataModel] = []
    var profileModel : ProfileModel?
    var postProfieDetails: PostedUserDetailsModel?
    var selectionType = -1
    var preference = 0
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
        userVM.getProfileData(userID: "")
        
    }
    func loadPostsData() {
        self.showLoader()
        userVM.getPostData(display_status: 2, group_id: "", page: 1, posted_id: "")
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
      return postsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if preference == 3 {
            let cell: QACell
            = tableView.dequeueReusableCell(withIdentifier: "QACell") as! QACell
            cell.configureWith(data: postsArray[indexPath.row])
           
            return cell
        } else {
            let cell: CaseCell
            = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
            cell.configureProfileData(profileData: postProfieDetails)
            cell.configureData(homeModel: postsArray[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileViewHeader.identifier) as? ProfileViewHeader {
            if  let profile = profileModel  {
                headerView.configureView(data: profile)
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



extension ProfileViewController: UserDetailsViewModelDelegate {
    func didReciveProfileData(response: ProfileModel?, error: String?) {
        self.dismiss()
        profileModel = response
        profileTableView.reloadData()
    }
    
    func didReciveGroupProfileData(response: GroupProfileModel?, error: String?) {
        
    }
    
    func didRecivePostsData(response: HomeResponseModel?, error: String?) {
        self.dismiss()
        postsArray = response?.homeResponse ?? []
        if let data = response?.userGroupDetails {
        postProfieDetails  = data
        }
        self.profileTableView.reloadData()
    }
}
extension ProfileViewController : CustomSegmentedControlDelegate {
    func change(to index: Int) {
       
        self.showLoader()
        postsArray = []
        switch index {
        case 0:
            preference = 2
        case 1:
            preference = 1
        case 2:
            preference = 3
        case 3:
            preference = 4
            
        default: break
        }
        userVM.getPostData(display_status: preference, group_id: "", page: 1, posted_id: "")
        
    }
}
