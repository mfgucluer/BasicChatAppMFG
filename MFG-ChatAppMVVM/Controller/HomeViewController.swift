//
//  HomeViewController.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 10/9/24.
//

import UIKit

private let reuseId = "UserCell"

class HomeViewController: UIViewController {

    //MARK: Properties
    private let tableView = UITableView()
    private var users = [User]()
    
    
    
    //MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Service.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        style()
        layout()
        
    }

}

// MARK: - Helpers

extension HomeViewController{
   
    private func style(){
        view.backgroundColor = .systemBackground
        //tableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseId)
        tableView.rowHeight = 75
//        tableView.separatorStyle = .none // aradaki cizgileri yok eder
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func layout(){
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]


        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatVC = ChatVC(user: users[indexPath.row])
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
}
