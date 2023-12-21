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
    
    override func configureView() {
        
        contentView.backgroundColor = CustomColor.backgroundColor
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
        contentView.layer.borderWidth = 0.5
        
        contentView.addSubview(emptyView)
        emptyView.addSubview(defaultLabel)
        emptyView.addSubview(detailLabel)
        
    }
    
    override func setConstraints() {
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        defaultLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(19)
            make.leading.equalToSuperview().offset(22)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.trailing.equalToSuperview().offset(-14)
            make.centerY.equalTo(emptyView)
        }
        
        
    }
    
    
    
}
