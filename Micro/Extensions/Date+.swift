//
//  Date+.swift
//  Micro
//
//  Created by pinocchio22 on 2/28/25.
//

import Foundation

extension Date {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    func toString() -> String {
        return Date.formatter.string(from: self)
    }
}
