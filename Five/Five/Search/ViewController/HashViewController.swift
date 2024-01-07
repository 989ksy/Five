//
//  HashViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/1/23.
//

import UIKit
import Kingfisher
import RxSwift

final class HashViewController: BaseViewController {
    
    let mainView = HashView()
    var dataSource : UICollectionViewDiffableDataSource<Int, ReadData>!
    var data : ReadData = ReadData(likes: [], image: [], comments: [], id: "", creator: Creator(id: "", nick: "", profile: ""), time: "", content: "", productID: "")
    
    let disposeBag = DisposeBag()
    
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
