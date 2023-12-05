//
//  FeedViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa

final class FeedViewController : BaseViewController, UISheetPresentationControllerDelegate {
    
    //MARK: - 기본세팅
    
    let mainView = FeedView()
    let viewModel = FeedViewModel()
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        mainView.feedCollectionView.delegate = self
        mainView.feedCollectionView.dataSource = self

        mainView.addContentButton.addTarget(self, action: #selector(addContentButtonTapped), for: .touchUpInside)
        
        
        setNavigationController()
    }
    
    
    //MARK: - 글 작성하기 버튼
    
    @objc func addContentButtonTapped() {
        
        let vc = ContentViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    //MARK: - 댓글 버튼
    
    @objc func commentButtonTapped() {
        
        let vc = CommentViewController()
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            
            //지원할 크기 지정
            sheet.detents = [.medium(), .large()]
            //크기 변하는거 감지
            sheet.delegate = self
            
            //시트 상단에 그래버 표시 (기본 값은 false)
            sheet.prefersGrabberVisible = true
            

        }
        
        present(vc, animated: true, completion: nil)
        
    }
    
    
    //MARK: - 내용보기 버튼
    
    @objc func contentButtonTapped() {
        
        let vc = JournalViewController()
        vc.modalPresentationStyle = .pageSheet
        
        if let sheet = vc.sheetPresentationController {
            
            //지원할 크기 지정
            sheet.detents = [.medium()]
            //크기 변하는거 감지
            sheet.delegate = self
            
            //시트 상단에 그래버 표시 (기본 값은 false)
            sheet.prefersGrabberVisible = true
            
//            //뒤 배경 흐리게 제거 (기본 값은 모든 크기에서 배경 흐리게 됨)
//            sheet.largestUndimmedDetentIdentifier = .medium
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - navigation
    
    func setNavigationController() {
        //타이틀 설정 (로고대용)
        title = "Five"
        
        //로고 UI 설정
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : CustomFont.logo25 ?? .boldSystemFont(ofSize: 24), NSAttributedString.Key.foregroundColor:CustomColor.pointColor ?? .systemYellow]
        
        //네비게이션 컬러
        self.navigationController?.navigationBar.tintColor = .black


        
    }
    
}



//MARK: - 컬렉션뷰 Extension

extension FeedViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as? FeedCollectionViewCell else {return UICollectionViewCell()}
        
        cell.commentButton.tag = indexPath.row
        cell.commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
        cell.contentButton.tag = indexPath.row
        cell.contentButton.addTarget(self, action: #selector(contentButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    
}
