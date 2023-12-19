//
//  SettingTableCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/20/23.
//

import UIKit
import SnapKit

class SettingTableCell : BaseTableViewCell {
    
    static let identifier = "SettingTableCell"
    
    let emptyView = {
        let view = UIView()
        return view
    }()
    
    let defaultLabel = {
        let label = UILabel()
        label.font = CustomFont.mediumGmarket15
        label.text = "text"
        label.textColor = .black
        return label
    }()
    
    let detailLabel = {
        let label = UILabel()
        label.font = CustomFont.lightGmarket13
        label.textColor = .darkGray
        return label
    }()
    
    let chevronImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.compact.right")
        view.tintColor = .lightGray
        return view
    }()
    
    override func configureView() {
        
        contentView.addSubview(emptyView)
        emptyView.addSubview(defaultLabel)
        emptyView.addSubview(chevronImageView)
        emptyView.addSubview(detailLabel)
        
    }
    
    override func setConstraints() {
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        defaultLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(12)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalTo(emptyView)
            make.size.equalTo(16)
            make.trailing.equalToSuperview().inset(14)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-6)
            make.centerY.equalTo(emptyView)
        }
        
        
    }
    
    
    
}
