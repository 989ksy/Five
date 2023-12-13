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
        bar.placeholder = "토픽 또는 키워드를 검색해 보세요." //"검색"
        bar.searchTextField.textAlignment = .center
        bar.searchTextField.font = CustomFont.mediumGmarket15
        return bar
    }()
    
    let resultTableView = {
        let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        view.backgroundColor = CustomColor.backgroundColor
        view.separatorStyle = .singleLine
        view.rowHeight = 280
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
