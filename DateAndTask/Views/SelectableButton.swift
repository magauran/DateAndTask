//
//  SelectableButton.swift
//  DateAndTask
//
//  Created by Алексей on 06.03.2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit.UIButton

class SelectableButton: UIButton {
    
    convenience init(text: String) {
        self.init(title: text, titleColor: UIColor.gray, highlightedColor: UIColor.lightGray, selectedTitleColor: UIColor.mayaBlue, font: UIFont.boldSystemFont(ofSize: 16))
    }
    
}
