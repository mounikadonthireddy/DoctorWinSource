//
//  RequestViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 06/05/22.
//

import UIKit

class RequestViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
    var followVM = RequestViewModel()
    var requestArray :[NotificationModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "RequestCell", bundle: nil), forCellReuseIdentifier: "RequestCell")
        followVM.delegate = self
        self.loadConnections()        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        tableView.reloadData()
    }
    func loadConnections() {
        //self.showLoader()
        followVM.getRequestDataFromAPI(userID: User.shared.userID)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RequestCell = tableView.dequeueReusableCell(withIdentifier: "RequestCell") as! RequestCell
        cell.cellConfigureWithConnectionData(data: requestArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = UIStoryboard(name: "Details", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
        nextVC.requestUserID = requestArray[indexPath.row].posted_id ?? ""
        nextVC.groupId = ""
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension RequestViewController: RequestViewModelDelegate {
    func didReceiveNotificationRes(response: NotificationResponseModel?, error: String?) {
        self.dismiss()
        requestArray = response?.followersDetails ?? []
        tableView.reloadData()
    }
    
   
}

