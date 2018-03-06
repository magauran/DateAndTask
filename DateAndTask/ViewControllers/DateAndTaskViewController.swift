//
//  DateAndTaskViewController.swift
//  DateAndTask
//
//  Created by Алексей on 28.02.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

class DateAndTaskViewController: UIViewController, UIScrollViewDelegate {

    var blurView: UIVisualEffectView!
    var mainView: UIView!
    
    var tasksButton: UIButton!
    var dateButton: UIButton!
    var saveButton: UIButton!
    
    var topBarStackView: UIStackView!
    var topBarButtons: [UIButton]!
    var selectedButtonTag = 0
    
    var scrollView: UIScrollView!
    
    var taskButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBlurEffect()
        self.setupMainView()
        self.setupButtons()
        self.setupContentView()
    }
    
    func setupBlurEffect() {
        self.view.backgroundColor = .clear
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        visualEffectView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.view.addSubview(visualEffectView)
        visualEffectView.bindEdgesToSuperview(attributes: [.top, .bottom, .left, .right])
    }
    
    func setupMainView() {
        self.mainView = UIView()
        self.mainView.layer.cornerRadius = 10
        self.mainView.backgroundColor = .white
        
        self.view.addSubview(self.mainView)
        self.mainView.equalHeightToSuperview(multiplier: 0.8)
        self.mainView.equalWidthToSuperview(multiplier: 0.9)
        self.mainView.centerToSuperview()
    }
    
    func setupButtons() {
        self.dateButton = SelectableButton(text: "Дата")
        self.dateButton.addTarget(self, action: #selector(switchViews), for: .touchUpInside)
        self.dateButton.tag = 0
        self.dateButton.isSelected = true

        self.tasksButton = SelectableButton(text: "Дело")
        self.tasksButton.addTarget(self, action: #selector(switchViews), for: .touchUpInside)
        self.tasksButton.tag = 1

        self.topBarButtons = [self.dateButton, self.tasksButton]

        self.topBarStackView = UIStackView(arrangedSubviews: [self.dateButton, self.tasksButton])
        self.topBarStackView.distribution = .fillEqually
        self.topBarStackView.setSizeConstraintConstant(height: 50.0)
        self.mainView.addSubview(self.topBarStackView)
        self.topBarStackView.bindEdgesToSuperview(attributes: [.leading, .top, .trailing])

        self.saveButton = UIButton(title: "Сохранить", titleColor: UIColor.mayaBlue, font: UIFont.boldSystemFont(ofSize: 16))
        self.mainView.addSubview(self.saveButton)
        self.saveButton.bindEdgesToSuperview(attributes: [.leading, .bottom, .trailing])
        self.saveButton.setSizeConstraintConstant(height: 50.0)
        self.saveButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
    }
    
    func setupContentView() {
        self.scrollView = UIScrollView()
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.addSubview(self.scrollView)
        scrollView.bindEdgesToSuperview(attributes: [.left, .right])
        self.mainView.addConstraint(NSLayoutConstraint(item: scrollView, attribute: .top, relatedBy: .equal, toItem: self.topBarStackView, attribute: .bottom, multiplier: 1, constant: 0))
        self.mainView.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: .bottom, relatedBy: .equal, toItem: self.saveButton, attribute: .top, multiplier: 1, constant: 0))
        self.scrollView.contentInsetAdjustmentBehavior = .never
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.delegate = self
        
        let stackView = UIStackView()
        self.scrollView.addSubview(stackView)
        stackView.bindEdgesToSuperview(attributes: [.left, .top, .right, .bottom])
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self.mainView, attribute: .centerY, multiplier: 1, constant: 0))
        
        let dateView = UIView()
        stackView.addArrangedSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addConstraint(NSLayoutConstraint(item: dateView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0))
        let datePicker = UIDatePicker()
        dateView.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        dateView.addConstraint(NSLayoutConstraint(item: datePicker, attribute: .centerY, relatedBy: .equal, toItem: dateView, attribute: .centerY, multiplier: 1, constant: 0))
        dateView.addConstraint(NSLayoutConstraint(item: datePicker, attribute: .centerX, relatedBy: .equal, toItem: dateView, attribute: .centerX, multiplier: 1, constant: 0))
        dateView.addConstraint(NSLayoutConstraint(item: datePicker, attribute: .width, relatedBy: .equal, toItem: dateView, attribute: .width, multiplier: 1, constant: 0))
        
        let taskView = UIView()
        stackView.addArrangedSubview(taskView)
        let taskButtonsStack = UIStackView()
        taskButtonsStack.distribution = .fillEqually
        taskButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        taskView.addSubview(taskButtonsStack)
        taskButtonsStack.centerToSuperview()
        taskButtonsStack.equalWidthToSuperview()
        taskButtonsStack.setSizeConstraintConstant(height: 50)
        
        for i in 0..<4 {
            let button = SelectableButton(text: "Дело\(i)")
            button.tag = i
            button.addTarget(self, action: #selector(chooseTask), for: .touchUpInside)
            taskButtonsStack.addArrangedSubview(button)
        }
        
    }
    
    @objc func chooseTask(sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func switchViews(sender: UIButton) {
        self.topBarButtons[self.selectedButtonTag].isSelected = false
        self.selectedButtonTag = sender.tag
        self.topBarButtons[self.selectedButtonTag].isSelected = true
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollView.contentOffset.x = CGFloat(self.selectedButtonTag) * self.mainView.frame.size.width
        })
    }
    
    @objc func saveData() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newSelectedTag = Int((scrollView.contentOffset.x / self.mainView.frame.size.width).rounded())
        if self.selectedButtonTag != newSelectedTag {
            self.topBarButtons[self.selectedButtonTag].isSelected = false
            self.selectedButtonTag = newSelectedTag
            self.topBarButtons[self.selectedButtonTag].isSelected = true
        }
    }
}
