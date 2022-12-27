//
//  UserDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 09/05/22.
//

import UIKit

class UserDetailsViewController: ViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var postViewHeight: NSLayoutConstraint!
    @IBOutlet weak var postPersonImage: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    var userDetailsModel : ProfileModel?
    var groupModel : GroupProfileModel?
    var postsArray:[HomeDataModel] = []
    var userVM = UserDetailsViewModel()
    var requestUserID = ""
    var groupId = ""
    var preference = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        postPersonImage.setCornerRadius(radius: Float(postPersonImage.frame.width)/2)
        postView.setCornerRadius(radius: Float(postView.frame.height)/2)
        self.profileTableView.register(UINib(nibName: "UserHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "UserHeaderView")
        profileTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        
       
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
    
   
    func loadGroupData() {
       // self.showLoader()
        if groupId != "" {
            userVM.getGroupProfileData(userID: User.shared.userID, groupId: groupId)
        } else if requestUserID != "" {
            userVM.getProfileData(userID: requestUserID)
        } else {
            userVM.getProfileData(userID: User.shared.userID)
        }
    }
    func loadPostsData() {
        //self.showLoader()
        userVM.getPostData(display_status: 2, group_id: groupId, page: 1, posted_id: requestUserID)
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
            cell.configureData(homeModel: postsArray[indexPath.row])
            return cell
        }
 
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let details = groupModel {
            if details.joined_status == true {
                return 412
            }
        }
        return 382
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "UserHeaderView") as? UserHeaderView {
            if let userDetails = userDetailsModel {
//                headerView.configureView(data: userDetails)
//                if userDetails.followStatus == true {
//                    headerView.joinBtn.setTitle("Following", for: .normal)
//                } else {
//                    headerView.joinBtn.setTitle("Follow", for: .normal)
//                }
//                headerView.joinBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
               
            }
            headerView.joinBtn.tag = 1
            if let details = groupModel {
                headerView.configureView(data: details)
                if details.admin_status == true {
                    headerView.joinBtn.setTitle("Edit", for: .normal)
                    headerView.joinBtn.tag = 2
                    postView.isHidden = false
                    postViewHeight.constant = 40
                } else if details.joined_status == true {
                headerView.joinBtn.setTitle("Joined", for: .normal)
                    postView.isHidden = false
                    postViewHeight.constant = 40
                } else {
                    headerView.joinBtn.setTitle("Join", for: .normal)
                    postViewHeight.constant = 0
                    postView.isHidden = true
                }
                headerView.joinBtn.addTarget(self, action: #selector(joinClicked(button:)), for: .touchUpInside)
            }
            headerView.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            headerView.followBtn.addTarget(self, action: #selector(followCountClicked(button:)), for: .touchUpInside)
//            headerView.postBtn.addTarget(self, action: #selector(postClicked(button:)), for: .touchUpInside)
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
    @IBAction func postClicked(_ sender: UIButton) {
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
//        if let userDetails = userDetailsModel {
//            self.showLoader()
//            let request = FollowRequest(follow_id: userDetails.dworks_id ?? "", dworks_id: User.shared.userID)
//
//        let resource = ProfileEditResource()
//        resource.followPerson(request: request) { result in
//            DispatchQueue.main.async {
//                self.dismiss()
//                switch result {
//                case .success(let data):
//                    if data != nil && data == true {
//                        self.loadGroupData()
//                        self.profileTableView.reloadData()
//                    }
//                case .failure(_):
//                    print("")
//                }
//
//            }
//
//        }
//        }
    }
    @objc func joinClicked(button: UIButton) {
        if button.tag == 2 {
            let str = UIStoryboard(name: "Add", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "CreateGroupViewController") as! CreateGroupViewController
            if let data = groupModel {
                nextVC.groupModel = data
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
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
    
    func didRecivePostsData(response: HomeResponseModel?, error: String?) {
        self.dismiss()
        postsArray = response?.homeResponse ?? []
        self.profileTableView.reloadData()
    }

    func didReciveProfileData(response: ProfileModel?, error: String?) {
        self.dismiss()
        if response != nil {
            userDetailsModel = response!
            profileTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

extension UserDetailsViewController : CustomSegmentedControlDelegate {
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
        userVM.getPostData(display_status: preference, group_id: groupId, page: 1, posted_id: requestUserID)
        
    }
}
