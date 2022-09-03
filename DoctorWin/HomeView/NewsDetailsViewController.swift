//
//  NewsDetailsViewController.swift
//  DoctorWin
//
//  Created by N517325 on 22/10/21.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var newsDetails: HomeDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsDetailsCell", bundle: nil), forCellReuseIdentifier: "NewsDetailsCell")

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
       tabBarController?.tabBar.isHidden = true
        
    }
    
   @objc  func backClicked(button: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    /*        self.navigationController?.popViewController(animated: true)

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NewsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell: NewsDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "NewsDetailsCell") as! NewsDetailsCell
        if let data  = newsDetails {
           // cell.configureData(homeModel: data)
        }
        cell.backBtn.addTarget(self, action: #selector(backClicked(button:)), for: .touchUpInside)
            return cell
    }
}
