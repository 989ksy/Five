//
//  PlaceholderTextView+Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 11/30/23.
//

import UIKit

//MARK: - textView Placeholder 설정

extension ContentViewController : UITextViewDelegate {

func textViewDidBeginEditing(_ textView: UITextView) {
    
    if mainView.contentTextView.textColor == .gray {
        mainView.contentTextView.text = nil
        mainView.contentTextView.textColor = .black
    }
}

func textViewDidEndEditing(_ textView: UITextView) {
    
    if mainView.contentTextView.text.isEmpty {
        mainView.contentTextView.text = "함께 하이파이브 하고 싶은 순간을 공유해주세요."
        mainView.contentTextView.textColor = UIColor.gray
    }
}


}
