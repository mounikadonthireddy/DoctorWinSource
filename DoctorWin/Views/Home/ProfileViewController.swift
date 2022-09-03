//
//  ProfileViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 14/04/22.
//

import UIKit

class ProfileViewController: ViewController,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var profileTableView: UITableView!
    
    var profileDataModel : ProfileDataModel!
    var profileVM = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //  let cellSize = CGSize(width:480 , height:480)
        
        profileTableView.register(ProfileViewHeader.nib, forHeaderFooterViewReuseIdentifier: ProfileViewHeader.identifier)
        
        profileTableView.register(UINib(nibName: "CaseCell", bundle: nil), forCellReuseIdentifier: "CaseCell")
        profileVM.delegate = self
        
       
        
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
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CaseCell
        = tableView.dequeueReusableCell(withIdentifier: "CaseCell") as! CaseCell
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ProfileViewHeader.identifier) as? ProfileViewHeader {
            if  profileDataModel != nil  {
                headerView.configureView(data: profileDataModel)
                headerView.viewBtn.addTarget(self, action: #selector(viewClicked(button:)), for: .touchUpInside)
                headerView.followBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
                headerView.followingBtn.addTarget(self, action: #selector(followingClicked(button:)), for: .touchUpInside)
                
            }

            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 470
    }
}

extension ProfileViewController  {
  

    
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
       profileTableView.reloadData()
    }
    
    
}
