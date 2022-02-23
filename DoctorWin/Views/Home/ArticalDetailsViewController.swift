//
//  ArticalDetailsViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 23/02/22.
//

import UIKit

class ArticalDetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var articalDetails: HomeDataModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ArticalDetailsCell", bundle: nil), forCellReuseIdentifier: "ArticalDetailsCell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
//        tabBarController?.tabBar.isHidden = true
        
    }
    
    @IBAction func backClicked(_ sender: Any) {
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
extension ArticalDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell: ArticalDetailsCell
            = tableView.dequeueReusableCell(withIdentifier: "ArticalDetailsCell") as! ArticalDetailsCell
        if let data  = articalDetails {
            cell.configureData(homeModel: data)
        }
            return cell
    }
}
