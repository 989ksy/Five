//
//  SearchView.swift
//  Five
//
//  Created by Seungyeon Kim on 12/5/23.
//

import UIKit
import SnapKit

final class SearchView : BaseView {
    
    let searchBar = {
        let bar = UISearchBar()
        bar.placeholder = "검색하고 싶은 유저의 닉네임을 입력하세요."
        bar.searchTextField.font = CustomFont.mediumGmarket15
        return bar
    }()
    
    let resultTableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        view.backgroundColor = CustomColor.backgroundColor
        view.separatorStyle = .none
        return view
    }()
    
    override func configureView() {
        addSubview(resultTableView)
    }
    
    override func setConstraints() {
        
        resultTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}
