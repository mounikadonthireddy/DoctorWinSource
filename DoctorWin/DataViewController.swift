//
//  DataViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 23/02/22.
//

import UIKit



class DataViewController: UIViewController {
    var inputArray: [String] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
extension DataViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inputArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

               if( !(cell != nil)) {
                   cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
               }

        cell!.textLabel?.text = inputArray[indexPath.row]
               return cell!
    }
    
    
}
