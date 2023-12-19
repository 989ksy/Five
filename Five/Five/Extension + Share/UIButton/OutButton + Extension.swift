//
//  OutButton + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/19/23.
//

import UIKit

class OutButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        titleLabel?.font = CustomFont.mediumGmarket13
        setTitleColor(.systemGray2, for: .normal)
    }
    
}

