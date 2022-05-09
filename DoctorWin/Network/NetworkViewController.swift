//
//  NetworkViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 18/04/22.
//

import UIKit

class NetworkViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var networkVM = NetworkViewModel()
    var connectionsArray :[NetworkModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NetworkCell", bundle: nil), forCellReuseIdentifier: "NetworkCell")
        
        self.tableView.register(UINib(nibName: "NetworkTableHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "NetworkTableHeader")
        networkVM.delegate = self
        self.loadConnections()
    }
    
    func loadConnections() {
        self.showLoader()
        networkVM.getNetworkDataFromAPI(userID: User.shared.userID)
    }
}
    
    extension NetworkViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return connectionsArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell:NetworkCell = tableView.dequeueReusableCell(withIdentifier: "NetworkCell") as! NetworkCell
            cell.cellConfigureWithConnectionData(data: connectionsArray[indexPath.row])
            cell.followBtn.addTarget(self, action: #selector(followBtnClicked(button:)), for: .touchUpInside)
            cell.followBtn.tag = connectionsArray[indexPath.row].userid ?? 0
            return cell
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "NetworkTableHeader") as? NetworkTableHeader {
                //
                headerView.followBtn.addTarget(self, action: #selector(followClicked(button:)), for: .touchUpInside)
                headerView.followingBtn.addTarget(self, action: #selector(followingClicked(button:)), for: .touchUpInside)
                headerView.inviteBtn.addTarget(self, action: #selector(inviteClicked(button:)), for: .touchUpInside)
                headerView.requestBtn.addTarget(self, action: #selector(requestClicked(button:)), for: .touchUpInside)

                return headerView
            }
            
            return nil
            
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 255
        }
        
        @objc func followClicked(button: UIButton) {
            let str = UIStoryboard(name: "Home", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "FollowViewController") as! FollowViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        @objc func followingClicked(button: UIButton) {
            let str = UIStoryboard(name: "Home", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "FollowingViewController") as! FollowingViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        @objc func inviteClicked(button: UIButton) {
            
        }
        @objc func requestClicked(button: UIButton) {
            let str = UIStoryboard(name: "Home", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "RequestViewController") as! RequestViewController
            self.navigationController?.pushViewController(nextVC, animated: true)            
        }
        @objc func followBtnClicked(button: UIButton) {
            let request = ComplaintFollowRequest(follow_id: "\(button.tag)", user_id: User.shared.userID)
            let resource = HomeResource()
            resource.followComplaint(request: request) { result in
                DispatchQueue.main.async {
                    if result != nil && result == true {
                        self.loadConnections()
                    }
                }
                
            }
        }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let str = UIStoryboard(name: "Home", bundle: nil)
            let nextVC = str.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
   
extension NetworkViewController: NetworkViewModelDelegate {
    func didReceiveFollowDataResponse(response: [FollowModel]?, error: String?) {
        
    }
    
    func didReceiveNetworkDataResponse(response: [NetworkModel]?, error: String?) {
        self.dismiss()
        if let res = response {
        connectionsArray = res
        }
        self.tableView.reloadData()
    }
}
