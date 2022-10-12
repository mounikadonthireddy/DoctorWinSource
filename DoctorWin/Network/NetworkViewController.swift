//
//  NetworkViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class NetworkViewController: ViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var topView: UIView!
    var groupVM = GroupViewModel()
    var peopleVM = PeopleViewModel()
    var groupArray :[GroupModel] = []
    var adminGroupArray :[GroupModel] = []
    var peopleArray :[PeopleModel] = []
    let collectionViewHeaderFooterReuseIdentifier = "NetworkCVHeaderView"
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.dropShadow()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        
        collectionView.register(UINib.init(nibName: "NetworkCVCell", bundle: nil), forCellWithReuseIdentifier: "NetworkCVCell")
        
        
        groupVM.delegate = self
        peopleVM.delegate = self
        self.loadGropConnections()
        self.loadPeopleConnections()
        collectionView.register(UINib(nibName: collectionViewHeaderFooterReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
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
            groupArray = res.other_groups ?? []
            adminGroupArray = res.admin_groups ?? []
            collectionView.reloadData()
        }
        
    }
}
extension NetworkViewController: PeopleViewModelDelegate {
    func didReceiveNetworkDataResponse(response: [PeopleModel]?, error: String?) {
        self.dismiss()
        if let res = response {
            peopleArray = res
            collectionView.reloadData()
        }
    }
    
    
}
extension NetworkViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedIndex ==  0  {
            return groupArray.count
        } else if selectedIndex == 1 {
            return peopleArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: NetworkCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NetworkCVCell", for: indexPath) as! NetworkCVCell
        if selectedIndex  == 0 {
            cell.cellConfigureWithGroupData(data: groupArray[indexPath.row])
        } else {
            cell.cellConfigureWithPeopleData(data: peopleArray[indexPath.row])
        }
        
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let headerView: NetworkCVHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier, for: indexPath) as! NetworkCVHeaderView
            headerView.loadGropsData(data: adminGroupArray)
            headerView.interfaceSegmented.delegate = self
            headerView.delegate = self
            //   headerView.titleLbl.text = titleArray[indexPath.section]
            
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let yourWidth = 100
        return CGSize(width: yourWidth, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex == 0 {
            self.navigateToUserDetails(reqId: "", groupId: "\(groupArray[indexPath.row].group_id ?? "")")
        } else {
        self.navigateToUserDetails(reqId: peopleArray[indexPath.row].dworks_id ?? "", groupId: "")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: CGFloat(adminGroupArray.count * 50) + CGFloat(120))
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
        self.collectionView.reloadData()
    }
    
    
}
extension NetworkViewController: NetworkGroupSelected {
    func selectedGroup(groupId: String) {
        if groupId == "request" {
            self.requestClicked()
        } else if groupId != "" {
            self.navigateToUserDetails(reqId: "", groupId: groupId)
        }
        print("group Id : \(groupId)")
    }
    
    
}
