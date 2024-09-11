//
//  MoreViewController.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 5/9/24.
//

import UIKit
import FirebaseAuth

protocol LogoutProtocol{
    func logoutPerformed()
}

class MoreViewController: UIViewController {
    let logoutButton = UIButton()
    var delegateLogout: LogoutProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        configureLogoutButton()
    }
    
    func configureLogoutButton(){
        view.addSubview(logoutButton)
        logoutButton.setTitle("CIKIS", for: .normal)
        logoutButton.addTarget(self, action: #selector(performLogout), for: .touchUpInside)
        logoutButton.backgroundColor = .purple
        logoutButton.setTitleColor(.lightText, for: UIControl.State.highlighted)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 350),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.widthAnchor.constraint(equalToConstant: 100),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func performLogout(){
        print("performLogout")
        
        let storedUser = UserDefaults.standard.object(forKey: "userName")
        let storedPassword = UserDefaults.standard.object(forKey: "password")
        if (storedUser as? String) != nil,
           (storedPassword as? String) != nil
        {
            UserDefaults.standard.removeObject(forKey: "userName")
            UserDefaults.standard.removeObject(forKey: "password")
        }
        
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error")
        }

        delegateLogout?.logoutPerformed()
    }

}
