//
//  OptionViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/15/23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class OptionViewController: BaseViewController {
    
    var postId : String? //전달 받은 포스트 id값
    let disposebag = DisposeBag()
    
    let deleteResult = BehaviorSubject<String>(value: "") //네트워크 값 담을 곳
    
    //MARK: - UI
    
    let deleteBtnView = {
        let view = UIView()
        return view
    }()
    
    let deleteImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "trash")?.withTintColor(.systemRed)
        view.contentMode = .scaleAspectFit
        view.tintColor = .systemRed
        return view
    }()
    
    let deleteLabel = {
        let view = UILabel()
        view.text = "삭제"
        view.textColor = .systemRed
        view.font = CustomFont.mediumGmarket17
        return view
    }()
    
    let deleteButton = {
        let view = UIButton()
        return view
    }()
    
    let dismissButton = {
        let btn = UIButton()
        btn.setTitle("취소", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 26
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.systemGray3.cgColor
        btn.titleLabel?.font = CustomFont.mediumGmarket17
        return btn
    }()
    
    //MARK: - ViewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColor.backgroundColor
        
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        bind()
    }
    
    //MARK: - 네트워크 통신
    
    func bind() {
        
        guard let id = postId else {return}
        
        //네트워크 통신
        //삭제 액션을 서버에 전송
        deleteButton
            .rx
            .tap
            .flatMap{
                APIManager.shared.deletePost(id: id)
            }
            .subscribe(with: self) { owner, response in
                
                switch response {
                case .success(let response):
                    print("===삭제 VC", response)
                    self.deleteResult.onNext(response.id)
                case .failure(let error):
                    print(error.errorDescription!)
                }
                
            }
            .disposed(by: disposebag)
        
        deleteButton
            .rx
            .tap
            .subscribe(with: self) { owner, _ in
                let alert = UIAlertController(title: "안내", message: "정말로 삭제하시겠습니까?", preferredStyle: .alert)
                let ok = UIAlertAction(title: "예", style:.default) { _ in
                    
                    //네트워크 결과
                    //화면전환
                    self.deleteResult
                        .subscribe(with: self) { owner, string in
                            if id == string {
                                
                                NotificationCenter.default.post(name: NSNotification.Name("VCTransited"), object: nil)
                                self.dismiss(animated: true)
                            }
                        }
                        .disposed(by: self.disposebag)
                }
                
                let cancel = UIAlertAction(title: "아니오", style: .cancel) { _ in
                    self.dismiss(animated: true)
                }
                
                alert.addAction(cancel)
                alert.addAction(ok)
                
                self.present(alert, animated: true)
            }
            .disposed(by: disposebag)
        
        
        
        
        
        
    }
    
    
    ///취소 버튼 클릭 시 창 닫음
    @objc func dismissButtonTapped() {
        dismiss(animated: true)
    }
    
    
    
    //MARK: - 뷰 세팅
    
    override func configureView() {
        view.addSubview(dismissButton)
        view.addSubview(deleteBtnView)
        deleteBtnView.addSubview(deleteImageView)
        deleteBtnView.addSubview(deleteLabel)
        deleteBtnView.addSubview(deleteButton)
    }
    
    override func setConstraints() {
        
        deleteBtnView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(15)
            make.height.equalTo(50)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        deleteImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        deleteLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.leading.equalTo(deleteImageView.snp.trailing).offset(26)
            make.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
    
}
