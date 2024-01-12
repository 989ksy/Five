//
//  TestViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/20/23.
//

import UIKit
import SnapKit

class TestViewController: BaseViewController {
    
    let tableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        view.addSubview(tableview)
        tableview.backgroundColor = .gray
    }
    
    override func setConstraints() {
        
        tableview.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
    }
    
}
