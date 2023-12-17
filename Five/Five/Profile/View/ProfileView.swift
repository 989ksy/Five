//
//  ProfileView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import SnapKit

class ProfileView : BaseView {
    
    let ProfiletableView = {
        let view = UITableView()
        view.register(ProfileSecondCell.self, forCellReuseIdentifier: "ProfileSecondCell")
        view.register(ProfileFirstCell.self, forCellReuseIdentifier: "ProfileFirstCell")
        view.separatorStyle = .none
        return view
    }()
    
    override func configureView() {
        addSubview(ProfiletableView)
    }
    
    override func setConstraints() {
        
        ProfiletableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    
        
    }
    
}
