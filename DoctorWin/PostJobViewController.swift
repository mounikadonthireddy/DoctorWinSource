//
//  PostJobViewController.swift
//  DoctorWin
//
//  Created by AHP on 22/03/2566 BE.
//

import UIKit

class PostJobViewController: UIViewController {
    @IBOutlet weak var interfaceSegmented: CustomSegmentedControl!{
        didSet {
            interfaceSegmented.setButtonTitles(buttonTitles: ["Doctors","Nurses",  "Technitions", "Etc."])
            interfaceSegmented.selectorViewColor = .black
            interfaceSegmented.selectorTextColor = .black
            interfaceSegmented.clipsToBounds = true
            interfaceSegmented.setCornerRadius(radius: 10)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHieght: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FAQCell", bundle: nil), forCellReuseIdentifier: "FAQCell")
        guard let confettiImageView = UIImageView.fromGif(frame: imageView.frame, resourceName: "gif_image") else { return }
        imageView.addSubview(confettiImageView)
        confettiImageView.startAnimating()

        // Do any additional setup after loading the view.
    }
    func configureData() {
        tableViewHieght.constant = 150 + (44 * 4)
    }
    @IBAction func backClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
extension PostJobViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FAQCell
        = tableView.dequeueReusableCell(withIdentifier: "FAQCell") as! FAQCell
        return cell
    }
    
    
}

extension UIImageView {
    static func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
        guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
            print("Gif does not exist at that path")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        guard let gifData = try? Data(contentsOf: url),
            let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
        var images = [UIImage]()
        let imageCount = CGImageSourceGetCount(source)
        for i in 0 ..< imageCount {
            if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: image))
            }
        }
        let gifImageView = UIImageView(frame: frame)
        gifImageView.animationImages = images
        return gifImageView
    }
}
