//
//  CommentViewController.swift
//  Five
//
//  Created by Seungyeon Kim on 12/3/23.
//

import UIKit

final class CommentViewController : BaseViewController {
    
    let mainView = CommentView()

    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.commentTableView.delegate = self
        mainView.commentTableView.dataSource = self
        
        mainView.commentTableView.rowHeight = UITableView.automaticDimension
        
    }

    
    
    
}


extension CommentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as? CommentTableViewCell else {return UITableViewCell()}
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택 시 회색셀렉션 제거
        tableView.reloadRows(at: [indexPath], with: .none)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return tableView.rowHeight
       }
    
    
    
}
