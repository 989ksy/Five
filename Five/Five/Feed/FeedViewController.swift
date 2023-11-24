//
//  FeedViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController : BaseViewController {
    
    let mainView = FeedView()
    let viewModel = FeedViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationController()
    }
    
    //MARK: - navigation
    
    func setNavigationController() {
        //타이틀 설정 (로고대용)
        title = "Five"
        
        //로고 UI 설정
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : CustomFont.logo25 ?? .boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor:CustomColor.pointColor ?? .systemYellow]
        
        //네비게이션 컬러
        self.navigationController?.navigationBar.tintColor = .black//Color.pointColor

        
        
    }
    
}

