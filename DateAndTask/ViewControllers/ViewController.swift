//
//  ViewController.swift
//  DateAndTask
//
//  Created by Алексей on 27.02.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textField: UITextField!
    var button: UIButton!
    var buttonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTextField()
        self.setupButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func setupTextField() {
        self.textField = UITextField()
        
        let font = UIFont(name: (textField.font?.fontName)!, size: 20.0)!
        textField.font = font
        textField.placeholder = "Новая задача"
        textField.autocorrectionType = .no
        
        self.view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 40))
        self.view.addConstraint(NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20))
        textField.addConstraint(NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
    }
    
    func setupButton() {
        button = UIButton(title: "Кнопка", titleColor: UIColor.mayaBlue, font: UIFont.boldSystemFont(ofSize: 16))
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.buttonBottomConstraint = NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -15.0)
        self.view.addConstraint(self.buttonBottomConstraint)
        self.view.addConstraint(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
    }

    @objc func buttonAction() {
        let modalViewController = DateAndTaskViewController()
        modalViewController.modalPresentationStyle = .overFullScreen
        self.present(modalViewController, animated: true, completion: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.buttonBottomConstraint.constant = -(keyboardSize.size.height + 15.0)
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.buttonBottomConstraint.constant = -15.0
        self.view.setNeedsLayout()
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
        
    }

}

