//
//  CommentView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/3/23.
//

import UIKit
import SnapKit

class CommentView : BaseView {
    
    let contentLabel = {
        let label = viewTitleLabel()
        label.text = "댓글"
        return label
    }()
    
    let upperLine = {
        let view = lineUIView()
        return view
    }()
    
    let commentTextField = {
        let txt = UITextField()
        txt.placeholder = "댓글을 남겨보세요."
        return txt
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
