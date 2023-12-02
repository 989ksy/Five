//
//  lineView + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit

class lineUIView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray3.cgColor
    }
    
}
