//
//  ShareButton + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/12/23.
//

import UIKit

class ShareButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        setImage(UIImage(named: "content")?.withTintColor(.black), for: .normal)
        contentMode = .scaleAspectFill
    }
    
}
