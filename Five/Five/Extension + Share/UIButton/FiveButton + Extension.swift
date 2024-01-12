//
//  FiveButton + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/12/23.
//

import UIKit

final class FiveButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        setImage(UIImage(named: "five")?.withTintColor(.black), for: .normal)
    }
    
}
