//
//  Date+Helpers.swift
//  Practices
//
//  Created by 김주형 on 2022/04/01.
//

import Foundation

extension Date{
    func descriptiveString(dateStyle:DateFormatter.Style = .short) -> String{
        
        let formatter = DateFormatter()
//        formatter.dateStyle = dateStyle
        formatter.dateFormat = "yyyy/MM/dd"
        
        let daysBetween = self.daysBetween(date:Date())
        
        if daysBetween == 0{
            return "Today"
        }
        else if daysBetween == 1{
            return "Yesterday"
        }
        else if daysBetween < 5 && daysBetween > 1{
            let weekIndex = Calendar.current.component(.weekday, from: self) - 1
            return formatter.weekdaySymbols[weekIndex]
        }
        
        return formatter.string(from: self)
    }
    
    func daysBetween(date : Date) -> Int {
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: date)
        if let daysBetween = calendar.dateComponents([.day], from: date1, to: date2).day {
            return daysBetween
        }
        return 0
    }
}
