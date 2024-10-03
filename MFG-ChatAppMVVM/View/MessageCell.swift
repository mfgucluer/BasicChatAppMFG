import UIKit
import SDWebImage

class MessageCell: UICollectionViewCell {
    
    //MARK: Properties
    var messageContainerViewLeft: NSLayoutConstraint!
    var messageContainerViewRight: NSLayoutConstraint!

    var message: Message? {
        didSet{ configure() }
    }
    
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let messageContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .systemBlue
        containerView.layer.cornerRadius = 15
        return containerView
    }()
    
    private let messageTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.font = UIFont.preferredFont(forTextStyle: .title3)
        return textView
    }()
    
    //MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Helpers
extension MessageCell {
    
    private func style() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 34 / 2
        
        messageContainerView.translatesAutoresizingMaskIntoConstraints = false
        messageTextView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layout() {
        addSubview(profileImageView)
        addSubview(messageContainerView)
        messageContainerView.addSubview(messageTextView)
        
        // Profil Resmi Constraint
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 34),
            profileImageView.heightAnchor.constraint(equalToConstant: 34),
            profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // Mesaj Konteyneri Constraint'leri
        messageContainerViewLeft = messageContainerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8)
        messageContainerViewRight = messageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        NSLayoutConstraint.activate([
            messageContainerView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            messageContainerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            
            messageTextView.topAnchor.constraint(equalTo: messageContainerView.topAnchor),
            messageTextView.leadingAnchor.constraint(equalTo: messageContainerView.leadingAnchor),
            messageTextView.trailingAnchor.constraint(equalTo: messageContainerView.trailingAnchor),
            messageTextView.bottomAnchor.constraint(equalTo: messageContainerView.bottomAnchor)
        ])
    }
    
    private func configure(){
        guard let message = self.message else { return }
        let viewModel = MessageViewModel(message: message)
        
        messageTextView.text = message.text
        messageContainerView.backgroundColor = viewModel.messageBackgroundColor
        
        // Eğer mesaj mevcut kullanıcı tarafından gönderildiyse sağda, karşı kullanıcı tarafından gönderildiyse solda olacak şekilde ayarlama.
        if viewModel.currentUserActive {
            // Mesajı sağa hizala
            messageContainerViewLeft.isActive = false
            messageContainerViewRight.isActive = true
            profileImageView.isHidden = true // Profil resmi gizlenir
        } else {
            // Mesajı sola hizala
            messageContainerViewRight.isActive = false
            messageContainerViewLeft.isActive = true
            profileImageView.isHidden = false // Karşı kullanıcının profil resmi gösterilir
        }
        
        // Profil resmi URL'sini ayarla
        if let profileImageUrl = viewModel.profileImageView {
            // URL'den resmi indirip yükleyebilirsin (örn. Kingfisher veya başka bir kütüphane ile)
            profileImageView.sd_setImage(with: profileImageUrl)
        }
        
        //koseleri bukme isi
        if viewModel.currentUserActive{
            messageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        }
        else{
            messageContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]

        }
        
    }
}
