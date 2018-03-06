//
//  UIButton+Extensions.swift
//  DateAndTask
//
//  Created by Алексей on 05.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//


import UIKit.UIButton

extension UIButton {
    
    convenience init(title: String? = nil, titleColor: UIColor? = nil, highlightedColor: UIColor? = nil, selectedTitleColor: UIColor? = nil, font: UIFont? = nil) {
        
        self.init(type: .custom)
       
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        
        if let titleColor = titleColor {
            self.setTitleColor(titleColor, for: .normal)
        }
        
        if let highlightedColor = highlightedColor {
            self.setTitleColor(highlightedColor, for: .highlighted)
        }
    
        if let selectedTitleColor = selectedTitleColor {
            self.setTitleColor(selectedTitleColor, for: .selected)
        }
        
        if let font = font {
            self.titleLabel?.font = font
        }
        
    }
    
}
    
    

