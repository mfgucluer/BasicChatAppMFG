//
//  SplashVC.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 11/9/24.
//

import Foundation


import UIKit

protocol SplashDelegate: AnyObject {
    func splashDidFinish()
}

class SplashVC: UIViewController {

    weak var delegate: SplashDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        splashAppearance()
        performSplashOperations()
    }

    func splashAppearance(){
        let image = UIImage(named: "splashImage")
        let imageView = UIImageView(image: image)
        // ImageView'ın boyut ve konumunu ayarlama
        imageView.frame = view.bounds
        imageView.contentMode = .scaleToFill // Veya .scaleAspectFit gibi diğer seçenekler
        // View'a ekleme
        view.addSubview(imageView)
    }
    func performSplashOperations() {
            // Splash'te yapmak istedigin işlemler
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                //Splash işlemi bittiğinde delegate üzerinden haber verin.
                self.delegate?.splashDidFinish()
            }
        }
}
