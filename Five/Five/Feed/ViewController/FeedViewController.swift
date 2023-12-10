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
        
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        setNavigationController()
        
        bind()
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        bind()
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
                
                //닉네임
                cell.nicknameLabel.text = "\(element.creator.nick)"
                
                //날짜
                let dateString = "\(element.time)"

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")

                if let date = dateFormatter.date(from: dateString) {
                    let formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)

                    cell.dateLabel.text = formattedDate
//                    print(formattedDate)
                } else {
                    print("유효하지 않은 날짜 형식: \(dateString)")
                }
                
                
                /*
                 킹피셔 사용법:
                 let url = URL(string: "https://example.com/image.png")
                 imageView.kf.setImage(with: url)
                 
                 예시: uploads/posts/1702111403536.jpeg
                 
                 */
                
                let url = URL(string: "\(BaseURL.base)" + element.image.first!)
                cell.imageView.kf.setImage(with: url)
                
                
            }
            .disposed(by: disposeBag)
        
//        Observable
//            .zip(
//                mainView.feedCollectionView.rx.modelSelected(ReadData.self),
//                mainView.feedCollectionView.rx.itemSelected)
//            .subscribe(with: self) { owner, value in
//                <#code#>
//            }
//            .disposed(by: disposeBag)
//
        mainView.feedCollectionView.rx.itemSelected
            .subscribe(with: self) { owner, indexPath in
                

            }
            .disposed(by: disposeBag)
        
        
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
    
    //decelerate : 스크롤 인지 bool값;
    //사용자가 스크롤을 멈추면 false.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

    
    
}
