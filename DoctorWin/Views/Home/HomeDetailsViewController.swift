//
//  HomeDetailsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 31/10/21.
//

import UIKit

class HomeDetailsViewController: UIViewController {
    @IBOutlet weak var HomeDetailsTableView: UITableView!
    var detailsModel : HomeDataModel!
    override func viewDidLoad() {
        super.viewDidLoad()

        HomeDetailsTableView.register(UINib(nibName: "HomeDetailsCell", bundle: nil), forCellReuseIdentifier: "HomeDetailsCell")
        HomeDetailsTableView.register(UINib(nibName: "CommentsCell", bundle: nil), forCellReuseIdentifier: "CommentsCell")

        tabBarController?.tabBar.isHidden = true
        self.HomeDetailsTableView.delegate = self
        self.HomeDetailsTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    @IBAction func backClikced(_ sender: Any) {
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
extension HomeDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return detailsModel.commentsArray?.count ?? 0
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell: HomeDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "HomeDetailsCell") as! HomeDetailsCell
        cell.configureCellWith(data: detailsModel)
        return cell
        } else {
            let cell: CommentsCell
                = tableView.dequeueReusableCell(withIdentifier: "CommentsCell") as! CommentsCell
            cell.configureCellWith(data: detailsModel.commentsArray![indexPath.row])
            return cell
        }
    }
   
    
    
}
