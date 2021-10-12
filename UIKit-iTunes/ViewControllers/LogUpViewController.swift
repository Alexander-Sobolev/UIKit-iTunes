//
//  LogUpViewController.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 12.10.2021.
//

import UIKit

class LogUpViewController: UIViewController, UITextFieldDelegate {
    
    private let firstNameTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "First Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let secondNameTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Second Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let phoneTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Phone"
        tf.keyboardType = .numberPad
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let emailTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Mail"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let passwordTF: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let buttonLogUP: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        button.setTitle("Log up", for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.layer.cornerRadius = 15
        picker.datePickerMode = .date
        picker.layer.borderWidth = 3
        picker.clipsToBounds = true
        picker.backgroundColor = .white
        picker.tintColor = .black
        picker.layer.borderColor = #colorLiteral(red: 0.8023108636, green: 0.912645682, blue: 0.89, alpha: 1)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        setItems()
        firstNameTF.delegate = self
        secondNameTF.delegate = self
        phoneTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTF.resignFirstResponder()
        secondNameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
    
    private func setItems() {
        
        view.addSubview(firstNameTF)
        NSLayoutConstraint.activate([
            firstNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            firstNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            firstNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            firstNameTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(secondNameTF)
        NSLayoutConstraint.activate([
            secondNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 10),
            secondNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            secondNameTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(phoneTF)
        NSLayoutConstraint.activate([
            phoneTF.topAnchor.constraint(equalTo: secondNameTF.bottomAnchor, constant: 10),
            phoneTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            phoneTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            phoneTF.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(emailTF)
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: phoneTF.bottomAnchor, constant: 10),
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
    }
}
