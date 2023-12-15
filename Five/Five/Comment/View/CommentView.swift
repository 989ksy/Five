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
        let label = ViewTitleLabel()
        label.text = "댓글"
        return label
    }()
    
    let upperLine = {
        let view = LineView()
        return view
    }()
    
    //MARK: - 댓글피드
    
    let commentTableView = {
        let view = UITableView()
        return view
    }()
    
    //MARK: - 댓글입력창
    let boxLine = {
        let view = LineView()
        return view
    }()
    
    let reactionCollectionView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let commentTextfieldBox = {
        let view = UIView()
        return view
    }()
    
    let commentTextField = {
        let txt = UITextField()
        txt.placeholder = "댓글을 남겨보세요."
        txt.textColor = .black
        txt.font = CustomFont.lightGmarket15
        txt.layer.borderColor = UIColor.systemGray4.cgColor
        txt.layer.borderWidth = 0.7
        txt.layer.cornerRadius = 16
        txt.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 16.0, height: 0.0))
        txt.leftViewMode = .always
        return txt
    }()
    
    
    override func configureView() {
        addSubview(contentLabel)
        addSubview(upperLine)
        addSubview(commentTableView)
        addSubview(commentTextfieldBox)
        addSubview(reactionCollectionView)
        reactionCollectionView.backgroundColor = .orange
        addSubview(boxLine)
        addSubview(commentTextField)
    }
    
    override func setConstraints() {
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(31)
            make.height.equalTo(16)
            make.centerX.equalToSuperview()
        }
        
        upperLine.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(22)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        commentTableView.snp.makeConstraints { make in
            make.top.equalTo(upperLine.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(commentTextfieldBox.snp.top)
        }
        
        commentTextfieldBox.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(174)
        }
        
        reactionCollectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(58)
            make.top.equalTo(commentTextfieldBox.snp.top)
        }
        
        boxLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(commentTextfieldBox.snp.top)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(38)
            make.top.equalTo(reactionCollectionView.snp.bottom).offset(8)
            make.bottom.greaterThanOrEqualTo(keyboardLayoutGuide.snp.top).offset(-8)
        }
        
    }
    
    
}
