//
//  BaseView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit

class BaseView : UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        
    }
    
    func setConstraints() {
        
    }
    
}
