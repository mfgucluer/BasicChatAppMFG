//
//  ChatVC.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 29/9/24.
//

import UIKit

private let reuseId = "MessageCell"
class ChatVC: UICollectionViewController {
    
    
    
    
    //MARK: Properties
    var messages = [Message]()
    private lazy var chatInputView = ChatInputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.1))
    private let user: User
    
    
    //MARK: Lifecycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        fetchMessage()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var inputAccessoryView: UIView?{
        get {return chatInputView}
    }

    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    //MARK: API-Serive
    private func fetchMessage(){
        Service.fetchMessages(user: user) { messageArray in
            self.messages = messageArray
            self.collectionView.reloadData()
        }
    }
    
    
}

//MARK: Helpers
extension ChatVC {
    private func style(){
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseId)
        chatInputView.delegate = self
    }
    
    private func layout(){
        
    }
    
    
    
    
}


//MARK: UICollectionViewDelegate/Datasourse
extension ChatVC {

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! MessageCell
        return cell
    }
}

extension ChatVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 16, right: 0)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 60)
    }
}



extension ChatVC: ChatInputViewProtocol {
    func sendMessage(_ chatInputView: ChatInputView, message: String) {
        Service.sendMessage(message: message, toUser: user) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            
        }
    }
}
