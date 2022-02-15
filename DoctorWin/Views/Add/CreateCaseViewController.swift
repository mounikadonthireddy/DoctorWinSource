//
//  CreateCaseViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 15/02/22.
//

import UIKit

class CreateCaseViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var casesArray: [CreateCaseModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "AddCaseTextCell", bundle: nil), forCellReuseIdentifier: "AddCaseTextCell")
        tableView.register(AddCasesTitleHeader.nib, forHeaderFooterViewReuseIdentifier: AddCasesTitleHeader.identifier)

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.generateModelForTitles()
        
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
extension CreateCaseViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return casesArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return casesArray[section].innerData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AddCaseTextCell
            = tableView.dequeueReusableCell(withIdentifier: "AddCaseTextCell") as! AddCaseTextCell
        cell.nameTF.placeholder = casesArray[indexPath.section].innerData[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddCasesTitleHeader.identifier) as? AddCasesTitleHeader {
            headerView.title.text = casesArray[section].title

            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func generateModelForTitles() {
        let first = CreateCaseModel(title: "Cheif Compaint", image: "", innerData: [ "Cheif Compaint"])
        
        let second = CreateCaseModel(title: "Patient History", image: "", innerData:["Present Illness", "Past Illness", "Drugs", "Personal", "Family"])
        
        let third = CreateCaseModel(title: "Patient Examination", image: "", innerData: [ "Physical Examination", "System Examination", "Local Examination"])
        
        let four = CreateCaseModel(title: "Investigation", image: "", innerData: [ "Vitus", "Lab Finding", "Imaging"])

        let five = CreateCaseModel(title: "Probable Diagnosis", image: "", innerData: [ "Probable Diagnosis"])

        casesArray.append(first)
        casesArray.append(second)
        casesArray.append(third)
        casesArray.append(four)
        casesArray.append(five)

        
    }
    
}

struct CreateCaseModel {
    let title: String
    let image: String
    let innerData:[String]
    
}


