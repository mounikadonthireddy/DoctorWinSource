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
        self.tableView.backgroundColor = UIColor.clear
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
        return casesArray[section].open ? casesArray[section].innerData.count : 0
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
            headerView.addBtn.setTitle(casesArray[section].addTitle, for: .normal)
            headerView.addBtn.addTarget(self, action: #selector(addClicked(sender:)), for: .touchUpInside)
            headerView.titleImage.image = UIImage(named: casesArray[section].image)

            headerView.addBtn.tag = section
            return headerView
        }
        
        return nil
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func generateModelForTitles() {
        let first = CreateCaseModel(title: "Cheif Compaint", image: "chief", open: false, addTitle: "+ Add", innerData: [ "Cheif Compaint"])
        
        let second = CreateCaseModel(title: "Patient History", image: "globe", open: false, addTitle: "+ Add", innerData:["Present Illness", "Past Illness", "Drugs", "Personal", "Family"])
        
        let third = CreateCaseModel(title: "Patient Examination", image: "exam", open: false, addTitle: "+ Add", innerData: [ "Physical Examination", "System Examination", "Local Examination"])
        
        let four = CreateCaseModel(title: "Investigation", image: "investigation", open: false, addTitle: "+ Add", innerData: [ "Vitus", "Lab Finding", "Imaging"])

        let five = CreateCaseModel(title: "Probable Diagnosis", image: "chief", open: false, addTitle: "+ Add", innerData: [ "Probable Diagnosis"])

        casesArray.append(first)
        casesArray.append(second)
        casesArray.append(third)
        casesArray.append(four)
        casesArray.append(five)

        
    }
    @objc func addClicked(sender: UIButton) {
        if sender.titleLabel?.text == "Hide" {
            casesArray[sender.tag].open = false
            casesArray[sender.tag].addTitle = "+ Add"
        } else {
            casesArray[sender.tag].open = true
            casesArray[sender.tag].addTitle = "Hide"
            
        }
        tableView.reloadData()
    }
}

struct CreateCaseModel {
    let title: String
    let image: String
    var open: Bool
    var addTitle: String
    let innerData:[String]
}


