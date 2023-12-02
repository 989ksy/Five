//
//  viewTitleLabel + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit

class viewTitleLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        font = CustomFont.mediumGmarket15
    }
    
}
