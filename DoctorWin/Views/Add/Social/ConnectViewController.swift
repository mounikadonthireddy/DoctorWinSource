//
//  ConnectViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit

class ConnectViewController: ViewController {
    @IBOutlet weak var tableView: UITableView!
  
   

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ConnectCell", bundle: nil), forCellReuseIdentifier: "ConnectCell")

        // Do any additional setup after loading the view.
       
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
    }
    func loadProfileData() {
        
    }
    
    
    @IBAction func backClicked(_ sender: UIButton) {
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
extension ConnectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ConnectCell = tableView.dequeueReusableCell(withIdentifier: "ConnectCell") as! ConnectCell
        cell.professionTF.optionArray = ApiEndpoints.occupationArray
        cell.qualificationTF.optionArray = ApiEndpoints.qualificationArray
        cell.genderTF.optionArray = ApiEndpoints.genderArray
        
     //   cell.cellConfigureWithConnectionData(data: connectionsArray[indexPath.row])
      cell.interest.addTarget(self, action: #selector(interstClicked(button:)), for: .touchUpInside)
        return cell
    }
    
    @objc func interstClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "InterstViewController") as! InterstViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
