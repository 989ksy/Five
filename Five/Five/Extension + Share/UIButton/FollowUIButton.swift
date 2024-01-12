//
//  FollowUIButton.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit

final class FollowUIButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        titleLabel?.font = CustomFont.mediumGmarket15
        setTitleColor(.darkGray, for: .normal)
        setTitle("팔로우하기", for: .normal)
    }
    
}
