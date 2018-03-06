//
//  UIView+Constraints.swift
//  DateAndTask
//
//  Created by Алексей on 28.02.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//


import UIKit

extension UIView {
    
    func bindEdgesToSuperview() {
        guard let superview = superview else {
            preconditionFailure("`superview` was nil – call `addSubview(view: UIView)` before calling `bindEdgesToSuperview()` to fix this.")
        }
        translatesAutoresizingMaskIntoConstraints = false
        ["H:|-0-[subview]-0-|", "V:|-0-[subview]-0-|"].forEach { visualFormat in
            superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: visualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        }
    }

    func bindEdgesToSuperview(attributes: [NSLayoutAttribute]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else {
            preconditionFailure("`superview` was nil – call `addSubview(view: UIView)` before calling `bindEdgesToSuperview` to fix this.")
        }
        for attribute in attributes {
            let constraint = NSLayoutConstraint(item: superview, attribute: attribute, relatedBy: .equal, toItem: self, attribute: attribute, multiplier: 1, constant: 0)
            superview.addConstraint(constraint)
        }
    }
    
    func centerToSuperview() {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else {
            preconditionFailure("`superview` was nil – call `addSubview(view: UIView)` before calling `centerToSuperview` to fix this.")
        }
        let horizontalConstraint = self.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let verticalConstraint = self.centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    func equalWidthToSuperview(multiplier: CGFloat = 1.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else {
            preconditionFailure("`superview` was nil – call `addSubview(view: UIView)` before calling `equalWidthToSuperview` to fix this.")
        }
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: superview, attribute: .width, multiplier: multiplier, constant: 0)
        superview.addConstraint(widthConstraint)
    }
    
    func equalHeightToSuperview(multiplier: CGFloat = 1.0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superview = self.superview else {
            preconditionFailure("`superview` was nil – call `addSubview(view: UIView)` before calling `equalHeightToSuperview` to fix this.")
        }
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: superview, attribute: .height, multiplier: multiplier, constant: 0)
        superview.addConstraint(heightConstraint)
    }
    
    func setSizeConstraintConstant(height: CGFloat? = nil, width: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(height))
            self.addConstraint(heightConstraint)
        }
        if let width = width {
            let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(width))
            self.addConstraint(widthConstraint)
        }
    }
    
}
