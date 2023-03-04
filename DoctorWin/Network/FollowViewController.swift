//
//  FollowViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 03/01/22.
//

import UIKit

class FollowViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var followVM = NetworkViewModel()
    var followArray :[FollowModel] = []
    var postId: String = ""
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
        followVM.getFollowDataFromAPI(userID: postId)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension FollowViewController: UITableViewDelegate, UITableViewDataSource {
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
extension FollowViewController: NetworkViewModelDelegate {
    func didReceiveFollowDataResponse(response: FollowResponse?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            if let res = response {
                self.followArray = res.userDetails ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func didReceiveNetworkDataResponse(response: [NetworkModel]?, error: String?) {
        
    }
    
    
}

