//
//  UserCell.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 12/9/24.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    
    var user: User? {
        didSet {
            configureUserCell()
        }
    }

    // MARK: Properties
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "SubTitle"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = . lightGray
        return label
    }()
    private var stackView = UIStackView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
        
    }
    
    //MARK: LifeCycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //    // Hücre seçildiğinde veya seçimi kaldırıldığında yapılacak işlemler

    }
    
    

}

//MARK: Helpers
extension UserCell{
    
    private func setup(){
        //profileImageView
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 30
        //stackView
        stackView = UIStackView(arrangedSubviews: [title, subTitle])
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        addSubview(profileImageView)
        addSubview(stackView)
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
        
            //
            stackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 4),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant:4),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)
        ])
    }
    
    private func configureUserCell(){
        guard let user = user else {return}
        self.title.text = user.name
        print(user.name)
        print(user.username)
        print(user.profileImageUrl)
        self.profileImageView.sd_setImage(with: URL(string: user.profileImageUrl))
        self.subTitle.text = user.username
    }
    
    
}
