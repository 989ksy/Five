//
//  SettingButton + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/19/23.
//

import UIKit

class SettingButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        setImage(UIImage(named: "setting")?.withRenderingMode(.alwaysTemplate).withTintColor(.white), for: .normal)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        tintColor = .darkGray
        backgroundColor = CustomColor.backgroundColor
    }
    
}

