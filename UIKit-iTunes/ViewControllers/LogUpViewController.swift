//
//  LogUpViewController.swift
//  UIKit-iTunes
//
//  Created by Alexander Sobolev on 12.10.2021.
//

import UIKit

class LogUpViewController: UIViewController, UITextFieldDelegate {
    
    let nameValid: String.ValidType = .name
    let mailValid: String.ValidType = .email
    let phoneValid: String.ValidType = .phone
    let passwordValid: String.ValidType = .password
    // Маска
    private let maxNumberCount = 11
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
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
        button.addTarget(self, action: #selector(logUp), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let allValidLabel: UILabel = {
        let label = UILabel()
        label.text = "Here you will see a hint for the correct filling of the fields"
        label.tintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.layer.cornerRadius = 15
        picker.datePickerMode = .date
        picker.clipsToBounds = true
        picker.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        picker.tintColor = .black
        picker.translatesAutoresizingMaskIntoConstraints = false
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
    
    @objc private func logUp() {
        
        let firstName = firstNameTF.text ?? ""
        let secondName = secondNameTF.text ?? ""
        let phone = phoneTF.text ?? ""
        let mail = emailTF.text ?? ""
        let password = passwordTF.text ?? ""

        if firstName.isValid(nameValid) && secondName.isValid(nameValid) && mail.isValid(mailValid) && password.isValid(passwordValid) && phone.count == 18 && validAge() == true {
            UserDefaultsData.shared.saveUser(firstName: firstName, seconName: secondName, phone: phone, email: mail, password: password, age: datePicker.date)
            allValidLabel.text = "Success"
            dismiss(animated: true, completion: nil)
        } else {
            allValidLabel.text = "Failure"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTF.resignFirstResponder()
        secondNameTF.resignFirstResponder()
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        return true
    }
   
    private func setTF(textField: UITextField, label: UILabel, validType: String.ValidType, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        textField.text = result
        
        if result.isValid(validType) {
            label.text = validMessage
            label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else {
            label.text = wrongMessage
            label.textColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        }
    }
    
    private func validAge() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true)
    }
    // Маска
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
            guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
            
            let range = NSString(string: phoneNumber).range(of: phoneNumber)
            var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
            
            if number.count > maxNumberCount {
                let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            if shouldRemoveLastDigit {
                let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
                number = String(number[number.startIndex..<maxIndex])
            }
            
            let maxIndex = number.index(number.startIndex, offsetBy: number.count)
            let regRange = number.startIndex..<maxIndex
            
            if number.count < 7 {
                let pattern = "(\\d)(\\d{3})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
            } else {
                let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
                number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
            }
            
            return "+" + number
        }
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            
            
            switch textField {
            case firstNameTF: setTF(textField: firstNameTF,
                                                  label: allValidLabel,
                                                  validType: nameValid,
                                                  validMessage: "First name valid",
                                                  wrongMessage: "Only characters A-z",
                                                  string: string,
                                                  range: range)
            case secondNameTF: setTF(textField: secondNameTF,
                                                   label: allValidLabel,
                                                   validType: nameValid,
                                                   validMessage: "Second name valid",
                                                   wrongMessage: "Only characters A-z",
                                                   string: string,
                                                   range: range)
            case phoneTF: let fullString = (textField.text ?? "") + string
                          textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 0)
                                                   setTF(textField: phoneTF,
                                                   label: allValidLabel,
                                                   validType: phoneValid,
                                                   validMessage: "Phone valid",
                                                   wrongMessage: "Please enter correct phone",
                                                   string: string,
                                                   range: range)
            case emailTF: setTF(textField: emailTF,
                                              label: allValidLabel,
                                              validType: mailValid,
                                              validMessage: "Mail valid",
                                              wrongMessage: "Please enter correct email",
                                              string: string,
                                              range: range)
            case passwordTF: setTF(textField: passwordTF, 
                                                 label: allValidLabel,
                                                 validType: passwordValid,
                                                 validMessage: "Password is valid",
                                                 wrongMessage: "Password must be at least 6 characters, must be a number, lowercase letter, uppercase letter",
                                                 string: string,
                                                 range: range)
            default: break
            }

            return false
        }
    
    private func setItems() {
        
        view.addSubview(firstNameTF)
        NSLayoutConstraint.activate([
            firstNameTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            firstNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            firstNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            firstNameTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(secondNameTF)
        NSLayoutConstraint.activate([
            secondNameTF.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 5),
            secondNameTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            secondNameTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            secondNameTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(phoneTF)
        NSLayoutConstraint.activate([
            phoneTF.topAnchor.constraint(equalTo: secondNameTF.bottomAnchor, constant: 5),
            phoneTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            phoneTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            phoneTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(emailTF)
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: phoneTF.bottomAnchor, constant: 5),
            emailTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            emailTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            emailTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(passwordTF)
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 5),
            passwordTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            passwordTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            passwordTF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 10),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.widthAnchor.constraint(equalToConstant: 150),
            datePicker.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(buttonLogUP)
        NSLayoutConstraint.activate([
            buttonLogUP.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            buttonLogUP.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonLogUP.widthAnchor.constraint(equalToConstant: 150),
            buttonLogUP.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(allValidLabel)
        NSLayoutConstraint.activate([
            allValidLabel.topAnchor.constraint(equalTo: buttonLogUP.bottomAnchor, constant: 5),
            allValidLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            allValidLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            allValidLabel.heightAnchor.constraint(equalToConstant: 70)
        
        ])
    }
}

