//
//  DateLabel + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/13/23.
//

import UIKit

final class DateLabel : UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        text = dateFormatter.dateFormat
        font = CustomFont.lightGmarket12
        textColor = .darkGray
    }
    
}
