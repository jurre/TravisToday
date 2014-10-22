//
//  DateParser.swift
//  Travis
//
//  Created by Jurre Stender on 22/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

class DateFormatter {
	private var formatter: NSDateFormatter

	init() {
		self.formatter = NSDateFormatter()
		self.formatter.dateStyle = NSDateFormatterStyle.ShortStyle
		self.formatter.timeStyle = NSDateFormatterStyle.MediumStyle
	}

	func format(date: NSDate) -> String {
		return self.formatter.stringFromDate(date)
	}

	class var sharedInstance: DateFormatter {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : DateFormatter? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = DateFormatter()
		}
		return Static.instance!
	}
}