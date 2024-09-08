//
//  Extension.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 5/9/24.
//

import UIKit


extension UIViewController {
    
    // MARK: - Helpers
    func configureGradientLayer(){
        let gradient = CAGradientLayer()
        gradient.locations = [0,1]
        gradient.colors = [UIColor.systemBlue.cgColor, UIColor.systemBrown.cgColor]
        gradient.frame = view.bounds
        view.layer.addSublayer(gradient)
    }
    
}
