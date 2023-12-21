//
//  CommentViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/3/23.
//

import UIKit
import RxSwift
import RxCocoa

final class CommentViewController : BaseViewController {
    
    let mainView = CommentView()
    let viewModel = CommentViewModel()
    let disposeBag = DisposeBag()
        
    var commentList : [CreateCommentResponse]?
    var postId : String?
    
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        //테이블뷰 설정
        mainView.commentTableView.delegate = self
        mainView.commentTableView.dataSource = self
        mainView.commentTableView.rowHeight = UITableView.automaticDimension
        
        bind()
        
    }
    
    func bind() {
        
        guard let id = postId else { return }
        
        //댓글 전송버튼 눌렀을때
        mainView.sentButton
            .rx
            .tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .withLatestFrom(mainView.commentTextField.rx.text.orEmpty, resultSelector: { _, query in
                return query
            })
            .flatMap{
                APIManager.shared.createComment(id: id, content: $0 )
            }
            .subscribe(with: self, onNext: { owner, response in
                switch response {
                case .success(let response):
                        
                    self.commentList?.insert(response, at: 0)
                    owner.mainView.commentTextField.text = ""
                    owner.mainView.commentTextField.placeholder = "댓글을 남겨보세요."
                    
                    NotificationCenter.default.post(name: NSNotification.Name("needToUpdate"), object: nil)
                    
                    owner.mainView.commentTableView.reloadData()
                                                            
                case .failure(let failure):
                    print(failure.errorDescription!)
                }
            })
            .disposed(by: disposeBag)
        
        
        
        
        
    }
    
    
    
    
}


extension CommentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
        return commentList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else {return UITableViewCell()}
                
        let data = commentList?[indexPath.row]
        
        cell.nicknameLabel.text = data?.creator.nick//닉네임
        cell.commentLabel.text = data?.content //내용
        cell.dateLabel.customDateFormat2(initialText: data?.time ?? "nil")//날짜
        
        //작성자 마크 표시
        if data?.creator.id != KeychainStorage.shared.userID! {
            cell.writerLabel.isHidden = true
        } else {
            cell.writerLabel.isHidden = false
        }

           
        return cell
        
    }
    
    ///댓글 삭제구현
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            guard let postID = postId else {return}
            guard let commentID = commentList?[indexPath.row].id else { return }
            
            viewModel.fetchDeleteComment(postId: postID, commentId: commentID) { response in
                print("==댓글삭제 함", response)
                NotificationCenter.default.post(name: NSNotification.Name("needToUpdate"), object: nil)
            }
            
            commentList?.removeAll { $0.id == commentID }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택 시 회색셀렉션 제거
        tableView.reloadRows(at: [indexPath], with: .none)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return tableView.rowHeight
       }
    
    
    
}
