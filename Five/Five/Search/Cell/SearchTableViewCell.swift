//
//  SearchCollectionViewCell.swift
//  Five
//
//  Created by Seungyeon Kim on 12/7/23.
//

import UIKit
import SnapKit

class SearchTableViewCell : BaseTableViewCell {
    
    private let profileImage = {
        let view = UIImageView()
        view.image = UIImage(named: "test_profile")
        view.layer.cornerRadius = 20
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let nicknameLabel = {
        let label = UILabel()
        label.text = "54번양현종"
        label.font = CustomFont.mediumGmarket15
        label.textColor = .black
        return label
    }()
    
    private let contentLabel = {
        let label = UILabel()
        label.text =
 """
 #KIA타이거즈 가 2023년도 캐치프레이즈 '압도하라 Always KIA TIGERS'를 확정하고 공개했다.
 
 KIA타이거즈에 따르면 '압도하라'는 1983년 V1 40주년을 기념하고 리그 최다 우승팀으로서의 자부심을 표현한 것으로, 2023 시즌 우승에 대한 선수단의 강력한 의지를 함축적으로 담았다.
 
 또한 '언제나 팬과 함께, 흩어지지 않는 ONE TEAM으로 나아간다'는 의미의 #Always KIA TIGERS 를 결합하여 팬 퍼스트를 바탕으로 지속적인 강팀으로 거듭나겠다는 목표를 표현했다.
 """
        label.font = CustomFont.lightGmarket15
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    
    override func configureView() {
        addSubview(profileImage)
        addSubview(nicknameLabel)
        addSubview(contentLabel)
    }
    
    override func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(10)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(10)
            make.height.equalTo(16)
            make.top.equalToSuperview().offset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(7)
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.bottom.lessThanOrEqualToSuperview()
            make.trailing.equalToSuperview().inset(12)
        }
        
        

    }
    
    
}
