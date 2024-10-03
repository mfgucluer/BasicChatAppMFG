//
//  Extension.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 5/9/24.
//

import UIKit
import JGProgressHUD


extension UIViewController {
    
    // MARK: - Helpers
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemBrown.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
    func showProgressHud(showProgress: Bool){
        let progress = JGProgressHUD(style: .dark)
        progress.textLabel.text = "Lütfen Bekleyiniz"
        
        showProgress ? progress.show(in: view): progress.dismiss()
    }
    
}


extension UIView {
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemBrown.cgColor]
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
}
