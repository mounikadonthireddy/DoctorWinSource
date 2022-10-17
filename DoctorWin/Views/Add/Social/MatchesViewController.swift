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
        
    }
    @IBAction func rejectClicked(_ sender: UIButton) {
        
    }
    @IBAction func messageClicked(_ sender: UIButton) {
        
    }
    @IBAction func wishlistClicked(_ sender: UIButton) {
        
    }
    @IBAction func likedClicked(_ sender: UIButton) {
        
    }
}
