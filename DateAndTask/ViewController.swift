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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextField()
        self.setupButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func setupTextField() {
        self.textField = UITextField()
        
        let font = UIFont(name: (textField.font?.fontName)!, size: 20.0)!
        textField.font = font
        textField.placeholder = "Новая задача"
        
        self.view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 30))
        self.view.addConstraint(NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 20))
        self.view.addConstraint(NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -20))
        textField.addConstraint(NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
    }
    
    func setupButton() {
        button = UIButton(type: .system)
        
        button.setTitle("Кнопка", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraint(NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: self.textField, attribute: .bottom, multiplier: 1, constant: 30))
        self.view.addConstraint(NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
    }

    @objc func buttonAction() {
        print("touch")
    }

}

