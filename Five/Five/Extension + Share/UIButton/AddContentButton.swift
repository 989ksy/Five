//
//  AddContentButton.swift
//  Five
//
//  Created by Seungyeon Kim on 12/17/23.
//

import UIKit

final class AddContentButton : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
       setImage(UIImage(named: "customPlus")?.withTintColor(.white), for: .normal)
        backgroundColor = CustomColor.pointColor
        layer.cornerRadius = 30
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

