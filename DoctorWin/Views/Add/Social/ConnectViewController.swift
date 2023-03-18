//
//  ConnectViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit

class ConnectViewController: ViewController, UIImagePickerControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    var interestVM = InterestViewModel()
    var interestArray: [InterestModel] = []
    var imagePicker: ImagePicker!
    var imageUpload1 : [AGImageStructInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        interestVM.delegate = self
        tableView.register(UINib(nibName: "ConnectCell", bundle: nil), forCellReuseIdentifier: "ConnectCell")
        loadInterests()
        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
        
    }
    func loadInterests() {
        self.showLoader()
        interestVM.loadAllInterest()
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
        cell.loadInterestArray(data: interestArray)
        cell.delegate = self
        cell.delegate1 = self
        
     //   cell.cellConfigureWithConnectionData(data: connectionsArray[indexPath.row])
     // cell.interest.addTarget(self, action: #selector(interstClicked(button:)), for: .touchUpInside)
        return cell
    }
    
    @objc func interstClicked(button: UIButton) {
        let str = UIStoryboard(name: "Network", bundle: nil)
        let nextVC = str.instantiateViewController(withIdentifier: "InterstViewController") as! InterstViewController
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
extension ConnectViewController: InterestViewModelDelegate {
    func didInterestData(response: InterestResponseModel?, error: String?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss()
            if error == nil {
                self.interestArray = response?.datingResponse ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func submitInterestResponse(res: BoolResponseModel?, error: String?) {
        
    }
    
    
}
extension ConnectViewController: ShowLoader {
    func update(bool: Bool?, error: String?) {
        if error != nil {
            let alert = UIAlertController(title: "Error", message: error!, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if error == nil && bool == true {
            self.showLoader()
        } else if bool == false {
            self.dismiss()
        }
    }

}
extension ConnectViewController: connectImagePickerDelegate {
    func pickImage() {
        self.imagePicker.present(from: self.view)
    }
    
    
}
extension ConnectViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?, fileName: String?, fileType: String?) {
        //self.imageView.image = image
       // self.imageFileName = fileName ?? ""
//        self.fileType = fileType ?? ""
        var cell = tableView.cellForRow(at: NSIndexPath(row: 0, section: 0) as IndexPath) as! ConnectCell
            //cell.displayImageView.image = image
        cell.imagesArray.append(image!)
        cell.ImagesCollectionView.reloadData()
        imageUpload1.append(AGImageStructInfo(fileName: fileName!, type: "image/jpeg", data: image!.toData()))
    }
    
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
   
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }

        return ""
    }
}

