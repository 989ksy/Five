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
    
    
}
