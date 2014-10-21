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
									return Repo(slug: slug, buildNumber: buildNumber, duration: duration, status: status, finishedAt: finishedAt)
								}
							}
						}
					}
				}
			}
		}

		return .None
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