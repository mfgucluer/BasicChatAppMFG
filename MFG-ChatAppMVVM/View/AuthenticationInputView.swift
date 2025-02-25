//
//  File.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 5/9/24.
//

import UIKit

class AuthenticationInputView: UIView {
    
    
    init(image: UIImage, textField: UITextField) {
        
        //Hicbir sey koymazsan o containerView'i temsil ediyor. Istersen self'de koyabilirsin. UIView
        
        super.init(frame: .zero)
        layer.cornerRadius = 15
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = image
        imageView.tintColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textField)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dividerView )
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            
            textField.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 8),
            
            dividerView.heightAnchor.constraint(equalToConstant: 0.70),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
 
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
