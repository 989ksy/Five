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
    
    var refresh = PublishSubject<Void>()
    
//    var likeList: [String] = []
    
    //리프레싱 컨트롤 생성
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshingData), for: .valueChanged)
        return refreshControl
        
    }()
    
    
    //MARK: - View
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        setNavigationController() //네비게이션바 세팅
        bind() // rx
        
        //리프레싱
        mainView.feedCollectionView.refreshControl = refreshControl
        
        NotificationCenter.default.addObserver(self, selector: #selector(uploadView), name: NSNotification.Name("needToUpdate"), object: nil)
        
    }
    
    //MARK: - 새 포스트 갱신
    
    @objc func uploadView() {
        refresh.onNext(Void())
    }
    
    
    //MARK: - 화면 로딩
    
    @objc private func refreshingData() {
        refreshControl.endRefreshing()
        refresh.onNext(Void())
    }
    
    
    //MARK: - Bind
    
    func bind() {
        
        let input = FeedViewModel.Input(
            addContentButtonTap: mainView.addContentButton.rx.tap,
            refresh: refresh,
            prefetchItem: mainView.feedCollectionView.rx.prefetchItems
        )
        let output = viewModel.transform(input: input)
        
        //작성하기 버튼 작동
        input.addContentButtonTap
            .subscribe(with: self) { owner, _ in
                let vc = ContentViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        //MARK: - FeedCollectionViewCell
        
        //CellForItem
        output.items
            .observe(on: MainScheduler.instance)
            .bind(
                to: mainView.feedCollectionView.rx.items(
                    cellIdentifier: "FeedCollectionViewCell",
                    cellType: FeedCollectionViewCell.self)
            ) { (row, element, cell) in
                
//                if self.likeList.contains(element.id) {
//                    cell.fiveButton
//                        .setImage(UIImage(named: "five.fill")?
//                            .withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
//                } else {
//                    cell.fiveButton
//                        .setImage(UIImage(named: "five"), for: .normal)
//                }
                
                //닉네임
                cell.nickLabel.text = "\(element.creator.nick)"
                //날짜
                cell.dateLabel.customDateFormat(initialText: element.time)
                
                //사진
                let url = URL(string: "\(BaseURL.base)" + element.image.first!)
                cell.imageView.loadImage(from: url!, placeHolderImage: UIImage(named: "personal"))
                
                //좋아요 버튼
                
                //1.[좋아요] 배열에서 내 아이디 확인
                // 있으면 색칠, 없으면 무색
                guard let userID = KeychainStorage.shared.userID else {return }
                
                if element.likes.contains(userID) {
                    cell.fiveButton
                        .setImage(UIImage(named: "five.fill")?
                            .withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
                } else {
                    cell.fiveButton
                        .setImage(UIImage(named: "five"), for: .normal)
                }

                //2. 파이브 버튼 누를 때 네트워크 통신
                cell.fiveButton
                    .rx
                    .tap
                    .flatMap {
                        APIManager.shared.likePost(id: element.id)
                    }
                    .subscribe(with: self) { owner, response in
                        switch response {
                        case .success(let response):
                            cell.likeStatus = response.likeStatus
                                     
                            if cell.likeStatus == true {
//                                self.likeList.append(element.id)
                                cell.fiveButton.setImage(UIImage(named: "five.fill")?
                                    .withTintColor(CustomColor.pointColor ?? .systemYellow), for: .normal)
                                
                            } else {
                                cell.fiveButton
                                    .setImage(UIImage(named: "five"), for: .normal)
                            
                            }
                            
                            NotificationCenter.default.post(name: NSNotification.Name("needToUpdate"), object: nil)
                            
                            print(response) // response.likeStatus 는 bool값
                        case .failure(let failure):
                            print("좋아요 버튼 통신문제:",failure)
                            print("error:", failure.errorDescription!)
                        }
                    }
                    .disposed(by: cell.disposeBag)
                
                
                //댓글 버튼
                cell.commentButton
                    .rx
                    .tap
                    .subscribe(with: self) { owner, _ in
                        let vc = CommentViewController()
                        
                        //포스트 아이디 넘김
                        vc.postId = element.id
                        vc.commentList = element.comments
                        
                        vc.modalPresentationStyle = .pageSheet
                        
                        if let sheet = vc.sheetPresentationController {
                            //지원할 크기 지정
                            sheet.detents = [.medium(), .large()]
                            //크기 변하는거 감지
                            sheet.delegate = self
                            
                            //시트 상단에 그래버 표시 (기본 값은 false)
                            sheet.prefersGrabberVisible = true
                        }
                        
                        self.present(vc, animated: true, completion: nil)
                    }
                    .disposed(by: cell.disposeBag)
                
                
                //닉네임 버튼
                cell.nicknameButton
                    .rx
                    .tap
                    .subscribe(with: self) { owner, _ in
                        let vc = ProfileViewController()
                    
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    .disposed(by: cell.disposeBag)
                
                
            }
            .disposed(by: disposeBag)
        
        
        
        //CellDidSelected
        mainView.feedCollectionView
            .rx
            .modelSelected(ReadData.self)
            .observe(on: MainScheduler.instance)
            .subscribe(with: self) { owner, data in
                let vc = PostViewController()
                vc.transitedData.accept(data)

                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        
        //CollectionView 갱신
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(with: self) { owner, _ in
                owner.mainView.feedCollectionView.reloadData()
                owner.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
        
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
        

    }
    
    
    
    
}
