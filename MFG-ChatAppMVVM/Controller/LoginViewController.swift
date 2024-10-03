//
//  LoginViewController.swift
//  MFG-ChatAppMVVM
//
//  Created by Mustafa Fatih on 5/9/24.
//

import UIKit
import FirebaseAuth

protocol LoginProtocol{
    func loggedIn()
}


class LoginViewController: UIViewController {

    
    var registerVC = RegisterViewController()
    
    // MARK: - Properties
    var loginDelegate: LoginProtocol?
    private var viewModel = LoginViewModel()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "ellipsis.message")
        imageView.tintColor = .white
        return imageView
    }()
    
    
    
    private lazy var emailContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "envelope")!, textField: emailTextField)
        return containerView
    }()
    
    //not: Ustteki tanimlama da olur bu da...
    
    private let emailTextField = CustomTextField(placeholder: "E-mail")
    
    private lazy var passwordContainerView: AuthenticationInputView = {
        let containerView = AuthenticationInputView(image: UIImage(systemName: "lock")!, textField: passwordTextField)
        return containerView
    }()
    
    private let passwordTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Password")
        //textField.isSecureTextEntry = true
        return textField
        
    }()
    private var stackView = UIStackView()
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.layer.cornerRadius = 20
        button.isEnabled = false //Suanlik bu tiklanamiyor. ViewModel'de yapacagiz bu isi.
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside) //Sari uyariyi uygulayinca crash veriyor.
        return button
    }()
    
    
    private lazy var switchtoRegistrationPage: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Click to become register", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 14)
        ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleGotoRegisterPage), for: .touchUpInside)
        
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureGradientLayer()
        style()
        layout()
    }
}

// MARK: Selector
extension LoginViewController {
    
    @objc func handleLoginButton(_ sender: UIButton){
   
        
        guard let emailText = emailTextField.text else {return}
        guard let passwordText = passwordTextField.text else {return}
        
        showProgressHud(showProgress: true)
        AuthenticationService.login(withEmail: emailText, password: passwordText) { result, error in
            if let error = error {
                print(error.localizedDescription)
                self.showProgressHud(showProgress: false)
                return
            }
            self.showProgressHud(showProgress: true)
            self.loginDelegate?.loggedIn()
        }
        
    }
    
    
    @objc func handleTextFieldChanged(_ sender: UITextField){
        if sender == emailTextField{
            viewModel.emailTextField = sender.text
        }
        else{
            viewModel.passwordTextField = sender.text
        }
        loginButtonStatus()
    }
    
    @objc private func handleGotoRegisterPage(_ sender: UIButton){
        
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
}


// MARK: Helpers
extension LoginViewController{
    private func loginButtonStatus(){
        if viewModel.status{
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemBlue
        }
        else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) //colorLiteral(
        }
    }

    private func style(){
        self.navigationController?.navigationBar.isHidden = true //bar olunca yukari gitmiyor.
        //logoImage
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        emailContainerView.translatesAutoresizingMaskIntoConstraints = false
        //stackView
        stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, loginButton])
        //Direkt tekte sinifin icinde bu sekilde baslatamayiz. Cunku sinifin icinde herhangi bir yerde bunun zamanini(ne zaman baslayacagini belirtmemis oluyoruz. ViewDidLoad'da falan yapman gerekecek. Extension'da yapabiliyoruz. Extension sonradan olan bir sey cunku.
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually //Herhangi birinin yuksekligi belli oldugu zaman 3unun de yuksekligini o yapiyor.
        stackView.translatesAutoresizingMaskIntoConstraints = false //usta bu ayari stackView olusturmadan onceye koy hicbir sey gorunmyor.
        //email and password textFields
        emailTextField.addTarget(self, action: #selector(handleTextFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextFieldChanged), for: .editingChanged)
        //switchtoRegistrationPage
        switchtoRegistrationPage.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout(){
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(switchtoRegistrationPage)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            logoImageView.heightAnchor.constraint(equalToConstant:  150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 32),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailContainerView.heightAnchor.constraint(equalToConstant: 50),
            
            switchtoRegistrationPage.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            switchtoRegistrationPage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            view.trailingAnchor.constraint(equalTo: switchtoRegistrationPage.trailingAnchor, constant: 32)
            
            
        ])
    }
    
    
}

