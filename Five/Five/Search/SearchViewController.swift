//
//  SearchViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit

final class SearchViewController: BaseViewController {
    
    let mainView = SearchView()
    
    override func loadView() {
        self.view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        self.navigationItem.titleView = mainView.searchBar
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
}
