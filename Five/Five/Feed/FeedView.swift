//
//  FeedView.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import SnapKit

class FeedView: BaseView {
    
    let storyAddButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"), for: .normal)
        btn.tintColor = CustomColor.pointColor
        btn.layer.cornerRadius = 30
        btn.layer.borderWidth = 2
        btn.layer.borderColor = CustomColor.pointColor?.cgColor
        return btn
    }()
    
    let storyTableView = {
        let view = UITableView()
        view.backgroundColor = .brown
        return view
    }()
    
    override func configureView() {
        
        addSubview(storyAddButton)
        addSubview(storyTableView)
    }
    
    override func setConstraints() {
        
        storyAddButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.size.equalTo(60)
            make.leading.equalToSuperview().offset(12)
        }
        
        storyTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(storyAddButton.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
        
        
    }
    
    
}
