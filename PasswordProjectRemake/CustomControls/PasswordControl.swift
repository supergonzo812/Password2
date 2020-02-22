//
//  PasswordControl.swift
//  PasswordProjectRemake
//
//  Created by Chris Gonzales on 2/22/20.
//  Copyright © 2020 Chris Gonzales. All rights reserved.
//

import UIKit

class PasswordControl: UIControl {
    
    // MARK: - Properties
    
    // UI Elements
    private let titleLabel: UILabel = UILabel()
    private let passwordTextField: UITextField = UITextField()
    private let strengthDescription: UILabel = UILabel()
    private let privateButton: UIButton = UIButton()
    
    private let cornerRadius: CGFloat = 10
    private let subViewBgOpacity: Float = 0.5
    private let passwordFieldBorderWidth: CGFloat = 1
    
    private let titleLabelFont: UIFont = UIFont.boldSystemFont(ofSize: 15)
    private let descriptionFont: UIFont = UIFont.systemFont(ofSize: 10,
                                                            weight: .semibold)
    
    private let openEyesImage: UIImage = UIImage(named: "eyes-open")!
    private let closedEyesImage: UIImage = UIImage(named: "eyes-closed")!
    
    // Colors
    private let unusedColor = UIColor(hue: 210/360.0,
                                      saturation: 5/100.0,
                                      brightness: 86/100.0,
                                      alpha: 1)
    private let weakBgColor = UIColor(hue: 0/360,
                                      saturation: 60/100.0,
                                      brightness: 90/100.0,
                                      alpha: 1)
    private let mediumColor = UIColor(hue: 39/360.0,
                                      saturation: 60/100.0,
                                      brightness: 90/100.0,
                                      alpha: 1)
    private let strongColor = UIColor(hue: 132/360.0,
                                      saturation: 60/100.0,
                                      brightness: 75/100.0,
                                      alpha: 1)
    private let bgColor = UIColor(hue: 0,
                                  saturation: 0,
                                  brightness: 97/100.0,
                                  alpha: 1)
    private let textFieldBorderColor = UIColor.black
    
    // Private Properties
    private let privateIsSelected: Bool = false
    private (set) var password: String = ""
    private let titleText = "Please enter a password"
    
    // MARK: - View Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setupLayouts()
    }
    
    @objc func shouldReturn (){
        passwordTextField.resignFirstResponder()
    }
    
    @objc func passwordVisibilityToggled() {
        
    }
    
    // MARK: - Setup Methods
    
    private func setupViews(){
        self.backgroundColor = bgColor
        self.layer.cornerRadius = cornerRadius
        passwordTextField.delegate = self
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = titleText
        titleLabel.font = titleLabelFont
        addSubview(titleLabel)
        
        privateButton.translatesAutoresizingMaskIntoConstraints = false
        privateButton.setImage(closedEyesImage,
                               for: .normal)
        privateButton.addTarget(self,
                                action: #selector(self.passwordVisibilityToggled),
                                for: .touchUpInside)
        privateButton.isEnabled = true
        addSubview(privateButton)
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.borderStyle = .bezel
        passwordTextField.placeholder = "Test text"
        passwordTextField.layer.borderColor = textFieldBorderColor.cgColor
        passwordTextField.layer.borderWidth = passwordFieldBorderWidth
        passwordTextField.backgroundColor = .white
        passwordTextField.isUserInteractionEnabled = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self,
                                    action: #selector(shouldReturn),
                                    for: .editingDidEnd)
        passwordTextField.rightViewMode = .always
        passwordTextField.rightView = privateButton
        addSubview(passwordTextField)
        addSubview(passwordTextField.rightView!)
        
        strengthDescription.translatesAutoresizingMaskIntoConstraints = false
        strengthDescription.text = "test"
        addSubview(strengthDescription)
    }
    
    private func setupLayouts(){
        
        let standardMargin: CGFloat = 8
        let titleLabelHeight: CGFloat = 30
        
        NSLayoutConstraint.activate([
            // control frame constraints
            self.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor),
            self.heightAnchor.constraint(equalToConstant: 150),
            // titleLabel constraints
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor,
                                            constant: standardMargin),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                constant: standardMargin),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabelHeight),
            // passwordTextField constraints
            passwordTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                   constant: standardMargin * 2),
            passwordTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,
                                                       constant: standardMargin),
            passwordTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor,
                                                        constant: -standardMargin),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            // privateButton constraints
            privateButton.topAnchor.constraint(equalTo: passwordTextField.topAnchor,
                                               constant: standardMargin),
            privateButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor,
                                                    constant: -standardMargin),
            privateButton.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                  constant: standardMargin),
            // strengthDescription constraints
            strengthDescription.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                     constant: standardMargin * 3),
            strengthDescription.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            strengthDescription.heightAnchor.constraint(equalToConstant: titleLabelHeight)
        ])
    }
    
    
    // MARK: - Background CG Setup
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    
}

extension PasswordControl: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in: oldText)!
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        //        determineStrength(ofPassword: newText)
        return true
    }
}
