//
//  NetworkViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class NetworkViewController: ViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    var groupVM = GroupViewModel()
    var peopleVM = PeopleViewModel()
    var groupArray :[GroupModel] = []
    var adminGroupArray :[AdminGroupModel] = []
    var peopleArray :[PeopleModel] = []
    let collectionViewHeaderFooterReuseIdentifier = "NetworkCVHeaderView"
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // topView.dropShadow()
        collectionView.register(UINib.init(nibName: "AdminGroupCell", bundle: nil), forCellWithReuseIdentifier: "AdminGroupCell")
        collectionView.register(UINib.init(nibName: "SegmentCell", bundle: nil), forCellWithReuseIdentifier: "SegmentCell")
        
        collectionView.register(UINib.init(nibName: "NetworkCVCell", bundle: nil), forCellWithReuseIdentifier: "NetworkCVCell")
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: headerKind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId)
        configureCompositionalLayout()
        
        groupVM.delegate = self
        peopleVM.delegate = self
        self.loadGropConnections()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func loadGropConnections() {
        self.showLoader()
        groupVM.getGroupNetworkDataFromAPI(userID: User.shared.userID)
    }
    func loadPeopleConnections() {
        self.showLoader()
        peopleVM.getPeopleNetworkDataFromAPI(userID: User.shared.userID)
    }
    @objc func followClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowViewController") as! FollowViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func followingClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func inviteClicked(button: UIButton) {
        
    }
    func requestClicked() {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @objc func followBtnClicked(button: UIButton) {
        let request = ComplaintFollowRequest(follow_id: "\(button.tag)", user_id: User.shared.userID)
        let resource = HomeResource()
        resource.followComplaint(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                    
                case .success(let data):
                    if data != nil && data == true {
                        self.loadPeopleConnections()
                    }
                case .failure(_):
                    print("")
                }
                
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        //   nextVC.RequestUserID = "\(connectionsArray[indexPath.row].userid ?? 0)"
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
   
}


extension NetworkViewController:  GroupViewModelDelegate {
    func didReceiveNetworkDataResponse(response: NetworkGroupModel?, error: String?) {
        self.dismiss()
        if let res = response {
            groupArray = res.otherGroups ?? []
            adminGroupArray = res.selfGroups ?? []
            collectionView.reloadData()
        }
        
    }
}
extension NetworkViewController: PeopleViewModelDelegate {
    func didReceiveNetworkDataResponse(response: PeopleResponseModel?, error: String?) {
        self.dismiss()
        if let res = response {
            peopleArray = res.userDetails ?? []
            collectionView.reloadData()
        }
    }
    
    
}
extension NetworkViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func configureCompositionalLayout() {
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) in
            if sectionNumber == 0  {
                return LayoutType.fullViewLayout.getLayout(withHeader: true, height: 55)
            } else if sectionNumber == 1 {
                return LayoutType.fullViewLayout.getLayout(height: 55)
            } else if sectionNumber == 2 {
                return LayoutType.fullViewLayout.getLayout(height: 75)
            }  else {
                return LayoutType.headerImageSectionLayout.getLayout(withHeader: false)
            }
        }
        
        layout.register(SectionDecorationView.self, forDecorationViewOfKind: sectionBackground)
        collectionView.setCollectionViewLayout(layout, animated: true )
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return adminGroupArray.count
        } else if section == 1 {
            return 1
        } else if section == 2 {
            if selectedIndex ==  0  {
                return groupArray.count
            } else if selectedIndex == 1 {
                return peopleArray.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: AdminGroupCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdminGroupCell", for: indexPath) as! AdminGroupCell
            cell.configureWithConnectionData(data: adminGroupArray[indexPath.row])
            return cell
        } else if indexPath.section == 1 {
            let cell: SegmentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SegmentCell", for: indexPath) as! SegmentCell
            cell.interfaceSegmented.delegate = self
            return cell
        } else {
            let cell: NetworkCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NetworkCVCell", for: indexPath) as! NetworkCVCell
            if selectedIndex  == 0 {
                cell.cellConfigureWithGroupData(data: groupArray[indexPath.row])
                cell.followBtn.addTarget(self, action: #selector(joinClicked(button:)), for: .touchUpInside)
            } else {
                cell.cellConfigureWithPeopleData(data: peopleArray[indexPath.row])
                cell.followBtn.addTarget(self, action: #selector(peopleFollowClicked(button:)), for: .touchUpInside)
            }
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Key.ReusableIdentifiers.sectionHeaderViewId, for: indexPath)
        as! SectionHeaderView
        
        header.title.text = "   My Groups"
        header.title.textColor = UIColor.black
        return header
    }
    @objc func joinClicked(button: UIButton) {
        
    }
    @objc func peopleFollowClicked(button: UIButton) {
        
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.navigateToUserDetails(reqId: "", groupId: adminGroupArray[indexPath.row].group_id ?? "")
        } else if indexPath.section == 2 {
            if selectedIndex == 0 {
                self.navigateToUserDetails(reqId: "", groupId: "\(groupArray[indexPath.row].group_id ?? "")")
            } else {
                self.navigateToUserDetails(reqId: peopleArray[indexPath.row].posted_id ?? "", groupId: "")
            }
        }
    }
    
    func navigateToUserDetails(reqId: String, groupId: String) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        nextVC.requestUserID = reqId
        nextVC.groupId = groupId
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension NetworkViewController: CustomSegmentedControlDelegate {
    func change(to index: Int) {
        selectedIndex = index
        switch index {
        case 0:
            self.loadGropConnections()
        case 1:
            self.loadPeopleConnections()
        case 2:
            let str = UIStoryboard(name: "Add", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "CreateGroupViewController") as! CreateGroupViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        default:
            print("nothing selected")
        }
        self.collectionView.reloadData()
    }
    
    
}
//extension NetworkViewController: NetworkGroupSelected {
//    func selectedGroup(groupId: String) {
//        if groupId == "request" {
//            self.requestClicked()
//        } else if groupId != "" {
//            self.navigateToUserDetails(reqId: "", groupId: groupId)
//        }
//        print("group Id : \(groupId)")
//    }
//
//
//}
