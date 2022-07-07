//
//  ProfileViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 14/04/22.
//

import UIKit

class ProfileViewController: ViewController,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var profileCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    let collectionViewHeaderFooterReuseIdentifier = "ProfileViewFooter"
    let collectionViewHeaderHeaderReuseIdentifier = "ProfileViewHeader"
    var names = ["Bookmarks", "Connect", "Cases", "News", "Resume", "Applied Jobs", "Post", "Article", "MCQs"]
    var profileDataModel : ProfileDataModel!
    var profileVM = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //  let cellSize = CGSize(width:480 , height:480)
        
        profileCollectionView.register(UINib.init(nibName: "ProfileCell", bundle: nil), forCellWithReuseIdentifier: "ProfileCell")
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        self.profileCollectionView.backgroundColor = UIColor.systemGroupedBackground
        profileVM.delegate = self
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        profileCollectionView.register(UINib(nibName: collectionViewHeaderFooterReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier)
        profileCollectionView.register(UINib(nibName: collectionViewHeaderHeaderReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderHeaderReuseIdentifier)
        
        parse()
        //collectionViewLayout.itemSize = cellSize
        
        // Do any additional setup after loading the view.
    }
    func parse() {
        self.showLoader()
        profileVM.getProfileData(userID: User.shared.userID)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tabBarController?.tabBar.isHidden = false
    }
    
}
extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProfileCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        cell.iconTitle.text = names[indexPath.item]
        cell.iconImage.image = UIImage(named: names[indexPath.item])
        // cell.name.backgroundColor = UIColor.white
        //        cell.backgroundColor = UIColor.white
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 2
        let spacingBetweenCells:CGFloat = 2
        
        // 2 is the value of sectionInset value
        
        let totalSpacing = (2 * 2) + ((numberOfItemsPerRow - 1) * spacingBetweenCells) //Amount of total spacing in a row
        let width = (profileCollectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        
        return CGSize(width: width, height: 110)
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
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
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderHeaderReuseIdentifier, for: indexPath) as? ProfileViewHeader
            
            if  profileDataModel != nil  {
                headerView?.configureView(data: profileDataModel)
                headerView?.viewBtn.addTarget(self, action: #selector(viewClicked(button:)), for: .touchUpInside)
                headerView?.followBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
                headerView?.followingBtn.addTarget(self, action: #selector(followingClicked(button:)), for: .touchUpInside)
                
            }
            // headerView.backgroundColor = UIColor.blue
            return headerView!
            
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderFooterReuseIdentifier, for: indexPath)
            
            //    footerView.backgroundColor = UIColor.green
            return footerView
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 360.0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 190.0)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 0:
            let str = UIStoryboard(name: "Me", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "BookmarksViewController") as! BookmarksViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            let str = UIStoryboard(name: "Network", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "ConnectViewController") as! ConnectViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            let str = UIStoryboard(name: "Me", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "MyCasesViewController") as! MyCasesViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case 3:
            let str = UIStoryboard(name: "Me", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "MyNewsViewController") as! MyNewsViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case 5:
            let str = UIStoryboard(name: "Job", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "AppliedJobViewController") as! AppliedJobViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case 7:
            let str = UIStoryboard(name: "Me", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "MyArticalViewController") as! MyArticalViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        case 8:
            let str = UIStoryboard(name: "Me", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "MCQViewController") as! MCQViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
        default:
            break
            
        }
    }
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
}


struct ProfileModel {
    let name: String
    let imageName: String
}
extension ProfileViewController: ProfileViewModelDelegate {
    
    func didReciveProfileExperienceData(response: [ExperienceModel]?, error: String?) {
        
    }
    
    
    func didReciveProfileData(response: ProfileDataModel?, error: String?) {
        self.dismiss()
        profileDataModel = response
        profileCollectionView.reloadData()
    }
    
    
}
