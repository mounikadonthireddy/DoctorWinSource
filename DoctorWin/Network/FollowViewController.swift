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
        followVM.getFollowDataFromAPI(userID: User.shared.userID)
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
    
    
}
extension FollowViewController: NetworkViewModelDelegate {
    func didReceiveFollowDataResponse(response: [FollowModel]?, error: String?) {
        self.dismiss()
        if let res = response {
            followArray = res
            tableView.reloadData()
        }
    }
    
    func didReceiveNetworkDataResponse(response: [NetworkModel]?, error: String?) {
        
    }
    
    
}

