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
        
        mainView.resultTableView.delegate = self
        mainView.resultTableView.dataSource = self
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else {return UITableViewCell()}
        
        return cell
    }

    
    
    
}
