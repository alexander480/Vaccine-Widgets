//
//  Extensions.swift
//  COVID-19 Data Widgets
//
//  Created by Alexander Lester on 6/9/21.
//

import Foundation

extension Double {
    func toPercentage() -> Int { return Int(self * 100) }
}

extension DateFormatter {
	static let yyyyMMdd: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter
	}()
}
