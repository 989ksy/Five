//
//  profileImageView + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/12/23.
//


import UIKit

final class ProfileImageView : UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        layer.cornerRadius = 15
        image = UIImage(named: "personal")?.withTintColor(.black)
        clipsToBounds = true
        contentMode = .scaleAspectFill
        layer.borderWidth = 1.1
        layer.borderColor = UIColor.systemGray5.cgColor
    }
    
}
