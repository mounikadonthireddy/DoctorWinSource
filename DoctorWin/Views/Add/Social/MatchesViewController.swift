//
//  MatchesViewController.swift
//  DoctorWin
//
//  Created by AHP on 22/09/2565 BE.
//

import UIKit

class MatchesViewController: ViewController {
    var datingArray: [MatchesModel] = []
    @IBOutlet weak var tableView: UITableView!
    var currentProfileIndex = -1
    var viewModel = DatingViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MatchesCell", bundle: nil), forCellReuseIdentifier: "MatchesCell")
        viewModel.delegate = self
        self.loadDatingProfiles()
    }
    func loadDatingProfiles() {
        self.showLoader()
        viewModel.getDatingProfilesData(userID: User.shared.userID)
    }
}
extension MatchesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if currentProfileIndex > -1 && currentProfileIndex < datingArray.count  {
            return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:MatchesCell = tableView.dequeueReusableCell(withIdentifier: "MatchesCell") as! MatchesCell
        cell.configureCellWith(data: datingArray[currentProfileIndex])
        return cell
    }
}
extension MatchesViewController: DatingViewModelDelegate {
    func didReciveDatingData(response: [MatchesModel]?, error: String?) {
        self.dismiss()
        datingArray = response ?? []
        if datingArray.count > 0 {
            currentProfileIndex  = 0
            // showProfile(index: 0)
            tableView.reloadData()
        }
    }
}
extension MatchesViewController {
    @IBAction func undoClicked(_ sender: UIButton) {
        let request = ProfileUndiRequest(dworks_id: User.shared.userID)
        let resource = DatingResource()
        resource.undoProfile(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    if data.undo == true {
//                        if self.datingArray.count - 1 != self.currentProfileIndex {
//                            self.currentProfileIndex = self.currentProfileIndex + 1
//                        } else {
//                            self.currentProfileIndex = 0
//                        }
                        self.tableView.reloadData()
                    } else {
                        
                    }
                case .failure(_):
                    print("")
                }
            }
            
        }
        
    }
    @IBAction func rejectClicked(_ sender: UIButton) {
        let request = ProfileSkipRequest(dworks_id: User.shared.userID, skip_profile_id: "\(datingArray[currentProfileIndex].user)")
        let resource = DatingResource()
        resource.skipProfile(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    if data.skiped_profile == true {
                        if self.datingArray.count - 1 != self.currentProfileIndex {
                            self.currentProfileIndex = self.currentProfileIndex + 1
                        } else {
                            self.currentProfileIndex = 0
                        }
                        self.tableView.reloadData()
                    } else {
                        
                    }
                case .failure(_):
                    print("")
                }
            }
            
        }
    }
    @IBAction func messageClicked(_ sender: UIButton) {
        
    }
    @IBAction func wishlistClicked(_ sender: UIButton) {
        let request = ProfileLikeRequest(dworks_id: User.shared.userID, like_id: "\(datingArray[currentProfileIndex].user)")
        let resource = DatingResource()
        resource.likeProfile(request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data) :
                    if data.likes == true {
                        if self.datingArray.count - 1 != self.currentProfileIndex {
                            self.currentProfileIndex = self.currentProfileIndex + 1
                        } else {
                            self.currentProfileIndex = 0
                        }
                        self.tableView.reloadData()
                    } else {
                        
                    }
                case .failure(_):
                    print("")
                }
            }
            
        }
    }
    @IBAction func likedClicked(_ sender: UIButton) {
        
    }
}
