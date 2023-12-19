//
//  DateFormaterLabel + Extension.swift
//  Five
//
//  Created by Seungyeon Kim on 12/13/23.
//

import UIKit

extension UILabel {
    
    func customDateFormat(initialText: String) {
        let dateString = initialText
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.locale = Locale(identifier: "ko_KR") //"en_US_POSIX"
        
        if let date = dateFormatter.date(from: dateString) {
            let formattedDate = DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
            self.text = formattedDate
        } else {
            print("Invalid date format: \(dateString)")
        }
    }
    
    func customDateFormat2(initialText: String) {
        let dateString = initialText
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            
            if let date = dateFormatter.date(from: dateString) {
                // 연도를 뺀 날짜를 구성
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day], from: date)
                
                // 재구성된 날짜를 포맷팅
                if let formattedDate = calendar.date(from: components) {
                    let resultDateString = DateFormatter.localizedString(from: formattedDate, dateStyle: .short, timeStyle: .none)
                    self.text = resultDateString
                } else {
                    print("Faile")
                }
            } else {
                print("Invalid date format: \(dateString)")
            }
    }
    
    
}
