//
//  LoginViewModel.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 7/9/24.
//

import Foundation

//Ekranda yapilan herhangi bir degisklik oldugu zaman viewModel'dan yardim aliriz
struct LoginViewModel{
    
    var emailTextField: String?
    var passwordTextField: String?
    var status: Bool{
        return emailTextField?.isEmpty == false && passwordTextField?.isEmpty == false
    }
}

