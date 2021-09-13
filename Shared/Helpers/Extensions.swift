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
	
	static let cdcDateFormat: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.locale = Locale(identifier: "en_US_POSIX")
		return formatter
	}()
}

extension Collection where Element == Int, Index == Int {
	/// Calculates a moving average.
	/// - Parameter period: the period to calculate averages for.
	/// - Warning: the supplied `period` must be larger than 1.
	/// - Warning: the supplied `period` should not exceed the collection's `count`.
	/// - Returns: a dictionary of indexes and averages.
	func movingAverage(period: Int) -> [Int: Float] {
		precondition(period > 1)
		precondition(count > period)
		let result = (0..<self.count).compactMap { index -> (Int, Float)? in
			if (0..<period).contains(index) { return nil }
			let range = index - period..<index
			let sum = self[range].reduce(0, +)
			let result = Float(sum) / Float(period)
			
			return (index, result)
		}
		return Dictionary(uniqueKeysWithValues: result)
	}
}
