//
//  RepoService.swift
//  Travis
//
//  Created by Jurre Stender on 22/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

extension Repo {
	class func fromJSONData(data: NSData) -> Repo? {
		var error: NSError?
		let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
		
		if let json = jsonOptional as? Dictionary<String, AnyObject> {
			if let repo = json["repo"]  as? Dictionary<String, AnyObject> {
				if let slug = repo["slug"] as? String {
					if let buildNumber = repo["last_build_number"] as? String {
						if let duration = repo["last_build_duration"] as? Int {
							if let status = repo["last_build_state"] as? String {
								if let finishedAt = repo["last_build_finished_at"] as AnyObject? as? String {
									let date = self.formattedDateString(finishedAt)
									return Repo(slug: slug, buildNumber: buildNumber, duration: duration, status: status, finishedAt: date)
								}
							}
						}
					}
				}
			}
		}

		return .None
	}

	private class func formattedDateString(dateString: String) -> String {
		let date = ISO8601DateParser.sharedInstance.parse(dateString)
		return DateFormatter.sharedInstance.format(date)
	}
}

class RepoService {
	class func find(slug: String, completion: (Bool, Repo?) -> Void) {
		let accept = "application/vnd.travis-ci.2+json"
		let url = NSURL(string: "https://api.travis-ci.org/repos/" + slug)
		let request = NSMutableURLRequest(URL: url!)
		request.setValue(accept, forHTTPHeaderField: "Accept")
		let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, request, error) -> Void in
			if (error != nil) {
				println(error.localizedDescription)
				completion(false, .None)
			} else {
				if let repo = Repo.fromJSONData(data) {
					completion(true, repo)
				} else {
					completion(false, .None)
				}
			}
		})
		task.resume()
	}
}

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