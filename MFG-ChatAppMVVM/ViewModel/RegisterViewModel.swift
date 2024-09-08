//
//  RegisterViewModel.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 8/9/24.
//

import Foundation


struct RegisterViewModel {
    var email: String?
    var name: String?
    var userName: String?
    var password: String?
    
    var status: Bool{
        return email?.isEmpty == false && password?.isEmpty == false && userName?.isEmpty == false && name?.isEmpty == false
    }
}
