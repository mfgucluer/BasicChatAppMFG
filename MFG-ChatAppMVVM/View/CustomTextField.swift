//
//  CustomTextField.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 5/9/24.
//

    import UIKit

    class CustomTextField: UITextField {
        
        init(placeholder: String){
            super.init(frame: .zero)
            
            self.placeholder = placeholder
            borderStyle = .none //textfiled'in etrafinda olusturdugu cerceveyi istemiyoruz
            textColor = .white
            backgroundColor = UIColor.clear
            
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
