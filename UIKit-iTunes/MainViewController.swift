//
//  ViewController.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 10.10.2021.
//

import UIKit

class MainViewController: UIViewController {

    private let emailTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Enter email"
        tf.isSecureTextEntry = true
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
        return button
    }()

    private let buttonLogIN: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.tintColor = .black
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setItems()
    }
}

//MARK: - setItems

extension MainViewController {
    
    private func setItems() {
        
        view.addSubview(emailTF)
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(passwordTF)
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 10),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            passwordTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(buttonLogUP)
        NSLayoutConstraint.activate([
            buttonLogUP.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 10),
            buttonLogUP.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogUP.widthAnchor.constraint(equalToConstant: 150),
            buttonLogUP.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(buttonLogIN)
        NSLayoutConstraint.activate([
            buttonLogIN.topAnchor.constraint(equalTo: buttonLogUP.bottomAnchor, constant: 10),
            buttonLogIN.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogIN.widthAnchor.constraint(equalToConstant: 150),
            buttonLogIN.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}





