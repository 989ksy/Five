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
        view.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentTableViewCell")
        view.backgroundColor = CustomColor.backgroundColor
        view.rowHeight = 60
        view.separatorStyle = .none
        return view
    }()
    
    //MARK: - 댓글입력창
    let boxLine = {
        let view = LineView()
        return view
    }()
    
    //
    
    let reactionStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    let heartButton = {
        let btn = UIButton()
        btn.setTitle("❤️", for: .normal)
        return btn
    }()
    
    let handsUpButton = {
        let btn = UIButton()
        btn.setTitle("🙌", for: .normal)
        return btn
    }()
    
    let fireButton = {
        let btn = UIButton()
        btn.setTitle("🔥", for: .normal)
        return btn
    }()
    
    let clapButton = {
        let btn = UIButton()
        btn.setTitle("👏", for: .normal)
        return btn
    }()
    
    let tearButton = {
        let btn = UIButton()
        btn.setTitle("🥲", for: .normal)
        return btn
    }()
    
    let loveItButton = {
        let btn = UIButton()
        btn.setTitle("😍", for: .normal)
        return btn
    }()
    
    let wowButton = {
        let btn = UIButton()
        btn.setTitle("😮", for: .normal)
        return btn
    }()
    
    let lolButton = {
        let btn = UIButton()
        btn.setTitle("😂", for: .normal)
        return btn
    }()
    
    
    
    //
    
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
    
    let sentButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "content")?.withTintColor(.darkGray), for: .normal)
        return btn
    }()
    
    override func configureView() {
        addSubview(contentLabel)
        addSubview(upperLine)
        addSubview(commentTableView)
        addSubview(commentTextfieldBox)
        addSubview(reactionStackView)
        reactionStackView.addArrangedSubview(heartButton)
        reactionStackView.addArrangedSubview(handsUpButton)
        reactionStackView.addArrangedSubview(fireButton)
        reactionStackView.addArrangedSubview(clapButton)
        reactionStackView.addArrangedSubview(tearButton)
        reactionStackView.addArrangedSubview(loveItButton)
        reactionStackView.addArrangedSubview(wowButton)
        reactionStackView.addArrangedSubview(lolButton)
        addSubview(boxLine)
        addSubview(commentTextField)
        addSubview(sentButton)
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
        
        reactionStackView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(commentTextfieldBox.snp.top)
        }
        
        boxLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(commentTextfieldBox.snp.top)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.trailing.equalToSuperview().inset(46)
            make.height.equalTo(38)
            make.top.equalTo(reactionStackView.snp.bottom).offset(8)
            make.bottom.greaterThanOrEqualTo(keyboardLayoutGuide.snp.top).offset(-8)
        }
        
        sentButton.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextField)
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(32)
            
        }
        
    }
    
    
}
