//
//  ChatInputView.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 29/9/24.
//

import UIKit

protocol ChatInputViewProtocol: AnyObject {
    func sendMessage(_ chatInputView: ChatInputView, message: String)
}


class ChatInputView: UIView {

    //MARK: Properties
    weak var delegate: ChatInputViewProtocol?
    private let textInputView: UITextField = {
        let textView = UITextField()
        textView.backgroundColor = .systemGray4
        textView.layer.cornerRadius = 15
        return textView
    }()
    
    private lazy var sendButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Send ", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleSendButton), for: .touchUpInside)
        return button
        
        
    }()
    
    
    //MARK: LifeCycle
    
    
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

extension ChatInputView {
    private func style(){
        configureGradientLayer()
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        textInputView.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
    }
    private func layout(){
        addSubview(textInputView)
        addSubview(sendButton)
        NSLayoutConstraint.activate([
            textInputView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            textInputView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            textInputView.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -4),
            bottomAnchor.constraint(equalTo: textInputView.bottomAnchor, constant: 25),
        
        
            sendButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            trailingAnchor.constraint(equalTo: sendButton.trailingAnchor, constant: 8),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55)
        
        ])
    }
}

extension ChatInputView {
    @objc private func handleSendButton(){
        guard let message = textInputView.text else { return  }
        self.delegate?.sendMessage(self, message: message)
        textInputView.text = ""
    }
    
   
}
