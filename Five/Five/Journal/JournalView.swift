//
//  JournalView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import SnapKit

class JournalView : BaseView {
    
    let contentLabel = {
        let label = viewTitleLabel()
        label.text = "내용"
        return label
    }()
    
    let upperLine = {
        let view = lineUIView()
        return view
    }()
    
    
    override func configureView() {
        addSubview(contentLabel)
        addSubview(upperLine)
    }
    
    override func setConstraints() {
        contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(16)
            make.centerX.equalToSuperview()
        }
        upperLine.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    
}
