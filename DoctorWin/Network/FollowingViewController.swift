//
//  FollowingViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 06/05/22.
//

import UIKit

class FollowingViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var followVM = NetworkViewModel()
    var followArray :[FollowModel] = []
    var userid: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FollowCell", bundle: nil), forCellReuseIdentifier: "FollowCell")
        followVM.delegate = self
        self.loadConnections()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    func loadConnections() {
        self.showLoader()
        followVM.getFollowingDataFromAPI(userID: userid)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension FollowingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FollowCell = tableView.dequeueReusableCell(withIdentifier: "FollowCell") as! FollowCell
        cell.cellConfigureWithFollowData(data: followArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        nextVC.requestUserID = followArray[indexPath.row].posted_id ?? ""
        //nextVC.groupId = groupId
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension FollowingViewController: NetworkViewModelDelegate {
    func didReceiveFollowDataResponse(response: FollowResponse?, error: String?) {
        self.dismiss()
        if let res = response {
            followArray = res.userDetails ?? []
            tableView.reloadData()
        }
    }
    
    func didReceiveNetworkDataResponse(response: [NetworkModel]?, error: String?) {
        
    }
    
    
}

