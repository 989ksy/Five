//
//  FeedViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 11/24/23.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class FeedViewController : BaseViewController, UISheetPresentationControllerDelegate {
    
    //MARK: - 기본세팅
    
    let mainView = FeedView() //메인 뷰
    let viewModel = FeedViewModel() //뷰모델
    
    let disposeBag = DisposeBag()
    
//    var feedItems : [CreatePostResponse] = []
    
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
//        print("+++feedViewController viewDidLoad: \(KeychainStorage.shared.userToken!)")
        
        setNavigationController()
        
        bind()
                
    }
    

    //MARK: - Bind
    
    func bind() {
        
        let input = FeedViewModel.Input(addContentButtonTap: mainView.addContentButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        //작성하기 버튼 작동
        input.addContentButtonTap
            .subscribe(with: self) { owner, _ in
                let vc = ContentViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        output.items
            .bind(to: mainView.feedCollectionView.rx.items(cellIdentifier: "FeedCollectionViewCell", cellType: FeedCollectionViewCell.self)) { (row, element, cell) in
                
                cell.nicknameLabel.text = "\(element.creator.nick)"
//                cell.imageView.image =
                
            }
            .disposed(by: disposeBag)
        
//        mainView.feedCollectionView.rx.itemSelected
//            .subscribe(with: self) { owner, indexPath in
//            }
        
        
    }
    
    
    //MARK: - 닉네임 버튼
    
    @objc func nicknameButtonTapped() {
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
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
            
            sheet.detents = [.medium()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
            
        }
        
        present(vc, animated: true, completion: nil)
    }
    
    
    //MARK: - navigation+item
    
    func setNavigationController() {
        
        //타이틀 설정(로고설정)
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 15))
        imageView.contentMode = .scaleAspectFit
            let image = UIImage(named: "logo")
            imageView.image = image
            navigationItem.titleView = imageView
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .black
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = CustomColor.backgroundColor
        appearance.configureWithTransparentBackground()
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        
    }
    
    
    //MARK: - 스크롤 시 네비게이션바 숨기기
    
    //사용자가
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    //decelerate;스크롤 인지 불리언; 사용자가 스크롤을 멈추면 false.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    
    
}




//MARK: - 컬렉션뷰 Extension
//
//extension FeedViewController : UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCollectionViewCell", for: indexPath) as? FeedCollectionViewCell else {return UICollectionViewCell()}
//        
//        //댓글버튼
//        cell.commentButton.tag = indexPath.row
//        cell.commentButton.addTarget(self, action: #selector(commentButtonTapped), for: .touchUpInside)
//        
//        //내용버튼
//        cell.contentButton.tag = indexPath.row
//        cell.contentButton.addTarget(self, action: #selector(contentButtonTapped), for: .touchUpInside)
//        
//        //프로필 닉네임버튼
//        cell.nicknameButton.tag = indexPath.row
//        cell.nicknameButton.addTarget(self, action: #selector(nicknameButtonTapped), for: .touchUpInside)
//        
//        return cell
//    }
//    
//    
//}
