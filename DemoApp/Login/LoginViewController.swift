//
//  LoginViewController.swift
//  DemoApp
//
//  Created by Satyendra Chauhan on 17/07/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 4/255, green: 203/255, blue: 168/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
       
        
        // Add subviews to stack view
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        
        // Add stack view to the main view
        view.addSubview(stackView)
        
        // Use SnapKit to set constraints
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.equalTo(200)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        registerButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
    }
    
    @objc func loginButtonTapped() {
        // Perform login authentication here
        // You can access the entered username and password using 'usernameTextField.text' and 'passwordTextField.text'
    }
    
    @objc func registerButtonTapped() {
        // Handle register button tap action
        // Navigate to the registration screen or perform registration logic
    }
}
