//
//  ConnectViewController.swift
//  DoctorWin
//
//  Created by Donthireddy Mounika on 13/05/22.
//

import UIKit
import iOSDropDown

class ConnectViewController: ViewController, UIImagePickerControllerDelegate {
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var bioTF: UITextField!
    @IBOutlet weak var livingTF: UITextField!
    @IBOutlet weak var qualificationTF: DropDown!
    @IBOutlet weak var professionTF: DropDown!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var genderTF: DropDown!
    @IBOutlet weak var interest: UIButton!
    @IBOutlet weak var heightTF: DropDown!
    @IBOutlet weak var lookingTF: UITextField!
    @IBOutlet weak var schoolTF: UITextField!
    @IBOutlet weak var incomeTF: UITextField!
    @IBOutlet weak var personalityTF: DropDown!
    @IBOutlet weak var occupationTF: DropDown!
    @IBOutlet weak var zodiacTF: DropDown!
    @IBOutlet weak var petsTF: DropDown!
    @IBOutlet weak var ImagesCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var InterestCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout1: UICollectionViewFlowLayout!
    @IBOutlet weak var dummyImage: UIImageView!
    var imageArray: [GenderImageModel] = []
    var interestArray: [InterestModel] = []
    var selectedInterest:[String] = []
    var viewModel =  EditConnectViewModel()
    var imagesArray: [UIImage] = []
   
    var interestVM = InterestViewModel()
   
    var imagePicker: ImagePicker!
    var imageUpload1 : [AGImageStructInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        interestVM.delegate = self
       
        loadInterests()
        // Do any additional setup after loading the view.
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        professionTF.optionArray = ApiEndpoints.occupationArray
      qualificationTF.optionArray = ApiEndpoints.qualificationArray
        genderTF.optionArray = ApiEndpoints.genderArray
        setCollectionView()
        
       
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
    func setCollectionView() {
        ImagesCollectionView.register(UINib.init(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "ImageCell")
        // Do any additional setup after loading the view.
        InterestCollectionView.register(UINib.init(nibName: "CourseNameCell", bundle: nil), forCellWithReuseIdentifier: "CourseNameCell")
//        viewModel.delegate = self
//        self.ImagesCollectionView.delegate = self
//        self.ImagesCollectionView.dataSource = self
        self.ImagesCollectionView.backgroundColor = UIColor.white
        //self.imagePicker = ImagePicker(presentationController: self, delegate: self)
      
        self.InterestCollectionView.backgroundColor = UIColor.white
        
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout1.scrollDirection = .vertical
        collectionViewLayout1.minimumLineSpacing = 0
        collectionViewLayout1.minimumInteritemSpacing = 0
        collectionViewLayout1.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        genderTF.optionArray = ApiEndpoints.genderArray
        zodiacTF.optionArray = ["Aries", "Taurus", "Gemini", "Cancer", "Leo", "Virgo", "Libra", "Scorpio","Sagittarius", "Capucorn", "Aquarius", "Pisces"]
        petsTF.optionArray = ["Cat" ,"Dog", "Reptile", "Amphibian" , "Dont have, but love", "Pet free", "App the pets"]
        personalityTF.optionArray = ["Introvert", "Extrovert", "Ambvert"]
        heightTF.optionArray = ["5'0","5'1","5'2","5'3","5'4","5'5","5'6","5'7","5'8","5'9","6'0","6'1","6'2","6'3"]
        qualificationTF.optionArray = ApiEndpoints.qualificationArray
        professionTF.optionArray = ApiEndpoints.occupationArray
        dobTF.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
       self.dummyImage.isHidden = true
    }
    @IBAction func updateClicked(_ sender: Any) {
        if nameTF.text?.count ?? 0 < 3 {
            self.update(bool: nil, error: "Please give a valid name")
            
        } else if genderTF.text == "" {
            self.update(bool: nil, error: "Please choose your gender")
        }  else if dobTF.text == "" {
            self.update(bool: nil, error: "Please choose your DOB")
        } else {
            self.update(bool: true, error: nil)
            let age:Int = Int(dobTF.text ?? "0") ?? 0
            let interest = selectedInterest.joined(separator: ",")
            let request =  ConnectProfileRequetModel(name: (nameTF.text ?? ""), intro: (bioTF.text ?? ""), gender: (genderTF.text ?? ""), age: "\(age)", living: (livingTF.text ?? ""), qualification: (qualificationTF.text ?? ""), profession: (professionTF.text ?? ""), height: (heightTF.text ?? ""), looking_for: (lookingTF.text ?? ""), living_in: (livingTF.text ?? ""), institute: (occupationTF.text ?? ""), orientation: (personalityTF.text ?? ""), zodiacs: (zodiacTF.text ?? ""), pets: (petsTF.text ?? ""), income: (incomeTF.text ?? ""), interest: interest)
            viewModel.createProfileData(request: request)
        }
    }
    @objc func doneButtonPressed() {
        if let  datePicker = self.dobTF.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            self.dobTF.text = dateFormatter.string(from: datePicker.date)
            self.dobTF.text =  "\(Date().years(from: datePicker.date)) yrs"
        }
        self.dobTF.resignFirstResponder()
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
               self.InterestCollectionView.reloadData()
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

        imageUpload1.append(AGImageStructInfo(fileName: fileName!, type: "image/jpeg", data: image!.toData()))
        self.imagesArray.append(image!)
        self.ImagesCollectionView.reloadData()
        
    }
    
}
extension ConnectViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == InterestCollectionView {
            return interestArray.count
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == InterestCollectionView {
            let cell: CourseNameCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CourseNameCell", for: indexPath) as! CourseNameCell
       
            cell.name.text = interestArray[indexPath.item].name
           // cell.backgroundColor = UIColor.blue
            cell.setCornerRadiusWithBorderColor(radius: 17.5, color: UIColor.secondaryLabel, borderWidth: 0.5)
         
            return cell
        } else  {
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.imageBtn.addTarget(self, action: #selector(imageClicked(button:)), for: .touchUpInside)
            if imageArray.count == 5 {
                if let urlString = imageArray[indexPath.row].image {
                    cell.profileImage.sd_setImage(with: URL(string:  urlString), placeholderImage: UIImage(named: "loginBg"))
                } else {
                    cell.profileImage.image = nil
                }
                
            }
    
        return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == InterestCollectionView {
            let size = ((interestArray[indexPath.row].name ?? "") as NSString).size(withAttributes: nil)
            return CGSize(width: size.width + 40, height: 35)
        } else {
            let yourWidth = ImagesCollectionView.frame.width/3
            let yourHeight = ImagesCollectionView.frame.height/2 - 8
            return CGSize(width: yourWidth, height: yourHeight)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == InterestCollectionView {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets.zero
        }//.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == InterestCollectionView {
        return 10
        } else {
            return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == InterestCollectionView {
            let selectedCell:UICollectionViewCell = collectionView.cellForItem(at: indexPath)!
            
            
            let selected = interestArray[indexPath.row].name ?? ""
            if selectedInterest.contains(selected) {
                
                selectedInterest.removeAll {$0 == selected }
                selectedCell.contentView.backgroundColor = UIColor(rgb: 0xFFFFFF)
                
            } else {
                selectedInterest.append(selected)
                selectedCell.contentView.backgroundColor = UIColor(rgb: 0x4986cc)
            }
            print(selectedInterest)
        } else {
            self.imagePicker.present(from: self.view)
        }
    }
    @objc func imageClicked(button: UIButton) {
        self.imagePicker.present(from: button)
    }
    
    
}
extension ConnectViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
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

