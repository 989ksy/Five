//
//  JournalView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import SnapKit

final class JournalView : BaseView {
    
    let contentLabel = {
        let label = ViewTitleLabel()
        label.text = "내용"
        return label
    }()
    
    let upperLine = {
        let view = LineView()
        return view
    }()
    
    
    override func configureView() {
        addSubview(contentLabel)
        addSubview(upperLine)
    }
    
    override func setConstraints() {
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(21)
            make.height.equalTo(16)
            make.centerX.equalToSuperview()
        }
        upperLine.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    
}
