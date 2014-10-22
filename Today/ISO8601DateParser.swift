//
//  ISO8601DateParser.swift
//  Travis
//
//  Created by Jurre Stender on 22/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

class ISO8601DateParser {
	private var formatter: NSDateFormatter

	init() {
		self.formatter = NSDateFormatter()
		self.formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
	}

	func parse(dateString: String) -> NSDate {
		return self.formatter.dateFromString(dateString)!
	}

	class var sharedInstance: ISO8601DateParser {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : ISO8601DateParser? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = ISO8601DateParser()
		}
		return Static.instance!
	}
}