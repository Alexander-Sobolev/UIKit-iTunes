//
//  ViewController.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 10.10.2021.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {

    private let emailTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let buttonLogUP: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log up", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logUp), for: .touchUpInside)
        return button
    }()

    private let buttonLogIN: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        return button
    }()
    
    private let validLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        emailTF.delegate = self
        passwordTF.delegate = self
        setItems()
       
    }
    
    @objc private func logUp() {
        self.present(LogUpViewController(), animated: true)
    }
    
    @objc private func logIn() {
        let mail = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        let user = userDB(mail: mail)

        if user == nil {
            validLabel.text = "This user was not found"
            validLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        } else if user?.password == password {
            let navigationVC = UINavigationController(rootViewController: PlaylistViewController())
            self.present(navigationVC, animated: true)
        } else {
            validLabel.text = "Invalid password"
            validLabel.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
    
    private func userDB(mail: String) -> User? {
        let data = UserDefaultsData.shared.users
        for user in data {
            if user.email == mail {
                return user
            }
        }
        return nil
    }
}

    //MARK: - setItems
extension MainViewController {
    
    private func setItems() {
        
        view.addSubview(emailTF)
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 180),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailTF.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
        view.addSubview(passwordTF)
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 10),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            passwordTF.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
        view.addSubview(buttonLogUP)
        NSLayoutConstraint.activate([
            buttonLogUP.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 10),
            buttonLogUP.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogUP.widthAnchor.constraint(equalToConstant: 150),
            buttonLogUP.heightAnchor.constraint(equalToConstant: 45)
            
        ])

        view.addSubview(buttonLogIN)
        NSLayoutConstraint.activate([
            buttonLogIN.topAnchor.constraint(equalTo: buttonLogUP.bottomAnchor, constant: 10),
            buttonLogIN.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogIN.widthAnchor.constraint(equalToConstant: 150),
            buttonLogIN.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
        view.addSubview(validLabel)
        NSLayoutConstraint.activate([
            validLabel.topAnchor.constraint(equalTo: buttonLogIN.bottomAnchor, constant: 10),
            validLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            validLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            validLabel.heightAnchor.constraint(equalToConstant: 45)
            
        ])
    }
}





