//
//  RegisterViewController.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 7/9/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage


protocol RegisterProtocol {
    func registered()
}



class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    var delegateRegister: RegisterProtocol?
    private var profileImage: UIImage?
    private var viewModel = RegisterViewModel()
    private lazy var addCameraButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(systemName: "camera.circle"), for: .normal)
        button.contentVerticalAlignment = .fill//Bu 2 ayar butonu büyütmek ve yaymak icin aslinda.
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(pickImage), for: .touchUpInside)
        return button
    }()
    
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return containerView
    }()
    
    private lazy var nameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person")!, textField: nameTextField)
        return containerView
    }()
    
    private lazy var usernameContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "person.icloud")!, textField: usernameTextField)
        return containerView
    }()
    
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    
    private let emailTextField = CustomTextField(placeholder: "E-mail")
    private let nameTextField = CustomTextField(placeholder: "Name")
    private let usernameTextField = CustomTextField(placeholder: "Username")
    private let passwordTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        //textField.isSecureTextEntry = true
        return textField
        
    }()
    
    private var stackView = UIStackView()
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 20
        button.isEnabled = false //Suanlik bu tiklanamiyor. ViewModel'de yapacagiz bu isi.
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title3)
        button.addTarget(self, action: #selector(handleRegisterButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var switchtoLoginPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Login Page", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleReturnLoginPage), for: .touchUpInside)
        
        return button
    }()
    
    
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    

   

}
// MARK: Selector
extension RegisterViewController {
    @objc func handleRegisterButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text else { return }
        guard let nameText = nameTextField.text else { return }
        guard let usernameText = usernameTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        guard let profileImageUpload = profileImage else { return }
        let user = AuthenticationServiceUser(emailText: emailText, passwordText: passwordText, nameText: nameText, usernameText: usernameText)
        showProgressHud(showProgress: true)
        AuthenticationService.register(profileImageUpload: profileImageUpload, user: user) { error in
            if let error = error {
                print("Error \(error.localizedDescription)")
                self.showProgressHud(showProgress: false)
                return
            }
            self.showProgressHud(showProgress: false)
            self.delegateRegister?.registered()
        }
    }
    
    @objc func handleTextFieldChanged(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.email = sender.text
        }
        else if sender == nameTextField {
            viewModel.name = sender.text
        }
        
        else if sender == usernameTextField{
            viewModel.userName = sender.text
        }
        
        else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        registerButtonStatus()
    }
    
    
    @objc private func handleReturnLoginPage(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func pickImage(_ sender: UIButton){
        let picker = UIImagePickerController()
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc func slideKeyboardUp(){
        self.view.frame.origin.y = -110
        
    }
    @objc func slideKeyboardDown(){
        self.view.frame.origin.y = 0
    }
}

// MARK: - Helpers
extension RegisterViewController {
    
    private func registerButtonStatus(){
        if viewModel.status{
            registerButton.isEnabled = true
            registerButton.backgroundColor = .systemBlue
        }
        else{
            registerButton.isEnabled = false
            registerButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) //colorLiteral(
        }
    }
    
    private func slideKeyboardUpNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(slideKeyboardUp), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(slideKeyboardDown), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    private func style(){
        configureGradientLayer()
        slideKeyboardUpNotifications()
        //addCameraButton
        addCameraButton.translatesAutoresizingMaskIntoConstraints = false
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView, nameContainerView, usernameContainerView, passwordContainerView, registerButton])
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //textfieldDidChanged
        emailTextField.addTarget(self, action: #selector(handleTextFieldChanged), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(handleTextFieldChanged), for: .editingChanged)
        usernameTextField.addTarget(self, action: #selector(handleTextFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChanged), for: .editingChanged)
        //switchLogin
        switchtoLoginPage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout(){
        view.addSubview(addCameraButton)
        view.addSubview(stackView)
        view.addSubview(switchtoLoginPage)
        NSLayoutConstraint.activate([
            addCameraButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            addCameraButton.heightAnchor.constraint(equalToConstant:  150),
            addCameraButton.widthAnchor.constraint(equalToConstant: 150),
            addCameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: addCameraButton.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchtoLoginPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            switchtoLoginPage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            view.trailingAnchor.constraint(equalTo: switchtoLoginPage.trailingAnchor, constant: 32)
            
        ])
        
        
    }
    
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profileImage = image
        addCameraButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        addCameraButton.layer.cornerRadius = 150/2
        addCameraButton.clipsToBounds = true
        addCameraButton.layer.borderColor = UIColor.white.cgColor
        addCameraButton.layer.borderWidth = 2
        addCameraButton.contentMode = .scaleAspectFill
        dismiss(animated: true)
    }
    
}
