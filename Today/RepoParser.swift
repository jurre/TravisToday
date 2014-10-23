//
//  RepoParser.swift
//  Travis
//
//  Created by Jurre Stender on 22/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

class RepoParser {
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