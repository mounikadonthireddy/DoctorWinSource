//
//  LoginVCExtension.swift
//  MvvmDemoApp
//
//  Created by CodeCat15 on 3/14/20.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation
import UIKit

extension LoginViewController : LoginViewModelDelegate {
    func didValidated(status: Bool, error: String?) {
        if status == false {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            self.showLoader()
        }
    }
    
    func didReceiveLoginResponse(wilNavigateTo: Bool, error: String?) {
        self.dismiss()
        if  error == nil {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
                nextVC.mobileNumber = self.mobileNumTF.text ?? ""
                self.navigationController?.pushViewController(nextVC, animated: true)
            }
        } else if wilNavigateTo == false && error != nil {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
                self.present(alert, animated: true)
            }
           
        }
    }
    
    
}

extension LoginViewController: UITextFieldDelegate {
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        let maxLength = 10
    //        let currentString: NSString = textField.text! as NSString
    //        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
    //        return newString.length <= maxLength
    //
    //    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        mobileNumTF.resignFirstResponder()
    }
}

extension LoginViewController: UIScrollViewDelegate {
    
    func createSlides() -> [Slide] {

        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "ic_onboarding_1")
        slide1.labelTitle.text = "Clinical Learning Videos"
        slide1.labelDesc.text = ""
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "ic_onboarding_2")
        slide2.labelTitle.text = "Medical Marketplace"
        slide2.labelDesc.text = ""
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "ic_onboarding_3")
        slide3.labelTitle.text = "Fina all Medical Jobs"
        slide3.labelDesc.text = ""
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "ic_onboarding_4")
        slide4.labelTitle.text = "Get your Answer"
        slide4.labelDesc.text = ""
        
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.imageView.image = UIImage(named: "ic_onboarding_5")
        slide5.labelTitle.text = "Find your equal match"
        slide5.labelDesc.text = ""
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: viewScroll.frame.width, height: viewScroll.frame.height)
      scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: viewScroll.frame.height)
        scrollView.isPagingEnabled = true

        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: viewScroll.frame.width * CGFloat(i), y: 0, width: viewScroll.frame.width, height: viewScroll.frame.height)
            scrollView.addSubview(slides[i])
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/viewScroll.frame.width)
        pageControl.currentPage = Int(pageIndex)

    }
    
    
    
    
    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
        if(pageControl.currentPage == 0) {

            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.pageIndicatorTintColor = pageUnselectedColor
        
            
            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            slides[pageControl.currentPage].backgroundColor = bgColor
            
            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
            pageControl.currentPageIndicatorTintColor = pageSelectedColor
        }
    }
    
    
    func fade(fromRed: CGFloat,
              fromGreen: CGFloat,
              fromBlue: CGFloat,
              fromAlpha: CGFloat,
              toRed: CGFloat,
              toGreen: CGFloat,
              toBlue: CGFloat,
              toAlpha: CGFloat,
              withPercentage percentage: CGFloat) -> UIColor {
        
        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
        
        // return the fade colour
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

