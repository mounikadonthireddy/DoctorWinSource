//
//  ProfileViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 14/04/22.
//

import UIKit

class ProfileViewController: ViewController,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var menuTableView: UITableView!
    var userDetailsModel : ProfileDataModel?
    var userVM = UserDetailsViewModel()
    var postsArray:[HomeDataModel] = []
    var profileModel : ProfileModel?
    var postProfieDetails: PostedUserDetailsModel?
    var selectionType = -1
    var preference = 0
    var menuArray = ["Contact us", "About us", "Terms& Conditions", "Privacy policy", "Invite Friend", "Logout"]
    let cellReuseIdentifier = "cell"
    var isMenuVisibile: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.setCornerRadius(radius: 10)
        menuTableView.dropShadow()
        profileTableView.register(ProfileViewHeader.nib, forHeaderFooterViewReuseIdentifier: ProfileViewHeader.identifier)
        
        profileTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        profileTableView.register(UINib(nibName: "HomeTableCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        
        profileTableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        profileTableView.register(UINib(nibName: "QACell", bundle: nil), forCellReuseIdentifier: "QACell")
        profileTableView.register(UINib(nibName: "UserAnswerCell", bundle: nil), forCellReuseIdentifier: "UserAnswerCell")
        self.navigationController?.isNavigationBarHidden = true
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
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
    @IBAction func menuClicked(_ sender: UIButton) {
        isMenuVisibile = !isMenuVisibile
        self.menuTableView.isHidden = isMenuVisibile
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        if tableView == profileTableView {
            return postsArray.count
        } else {
            return 6
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == profileTableView {
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
        } else {
            
            let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
            cell.textLabel?.text = menuArray[indexPath.row]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == profileTableView {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileViewHeader.identifier) as? ProfileViewHeader {
                if  let profile = profileModel  {
                    headerView.configureView(data: profile)
                    headerView.viewBtn.addTarget(self, action: #selector(viewClicked(button:)), for: .touchUpInside)
                    headerView.followBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
                    headerView.followingBtn.addTarget(self, action: #selector(followingClicked(button:)), for: .touchUpInside)
                    
//                    //                headerView.resumeBtn.addTarget(self, action: #selector(resumeClicked(button:)), for: .touchUpInside)
//                    headerView.bookmarkBtn.addTarget(self, action: #selector(bookmarkClicked(button:)), for: .touchUpInside)
                }
                headerView.interfaceSegmented.delegate  = self
                return headerView
            }
        }
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == profileTableView {
            return UITableView.automaticDimension
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == menuTableView {
            return 50
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menuTableView {
            if indexPath.row == 0 {
                if let url = URL(string: "tel://8500001406") {
                    UIApplication.shared.open(url)
                }
            } else if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 {
                let str = UIStoryboard(name: "Me", bundle: nil)
                let nextVC = str.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            } else if indexPath.row == 4 {
                let urlString = "https://www.google.com"
                let linkToShare = [urlString]
                let activityController = UIActivityViewController(activityItems: linkToShare, applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            } else if indexPath.row == 5 {
                UserDefaults.standard.set(nil, forKey: "token")
                let str = UIStoryboard(name: "Main", bundle: nil)
                let nextVC = str.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        }
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
        nextVC.postId = profileModel?.posted_id ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    @objc func followingClicked(button: Any) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
        nextVC.userid = profileModel?.posted_id ?? ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func bookmarkClicked(button: Any) {
        let str = UIStoryboard(name: "Me", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "BookmarksViewController") as! BookmarksViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func resumeClicked(button: Any) {
    }
   
}



extension ProfileViewController: UserDetailsViewModelDelegate {
    func didReciveProfileData(response: ProfileModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.profileModel = response
            self.profileTableView.reloadData()
        }
    }
    
    func didReciveGroupProfileData(response: GroupProfileModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
        }
    }
    
    func didRecivePostsData(response: HomeResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            self.postsArray = response?.homeResponse ?? []
            if let data = response?.userGroupDetails {
                self.postProfieDetails  = data
            }
            self.profileTableView.reloadData()
        }
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
