//
//  RepoService.swift
//  Travis
//
//  Created by Jurre Stender on 22/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation



class RepoService {
	class var sharedService: RepoService {
		struct Static {
			static var onceToken : dispatch_once_t = 0
			static var instance : RepoService? = nil
		}
		dispatch_once(&Static.onceToken) {
			Static.instance = RepoService()
		}
		return Static.instance!
	}
	
	func find(slug: String, completion: (Bool, Repo?) -> Void) {
		let accept = "application/vnd.travis-ci.2+json"
		let url = NSURL(string: "https://api.travis-ci.org/repos/" + slug)
		let request = NSMutableURLRequest(URL: url!)
		request.setValue(accept, forHTTPHeaderField: "Accept")
		let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, request, error) -> Void in
			if (error != nil) {
				println(error.localizedDescription)
				completion(false, .None)
			} else {
				if let repo = RepoParser.fromJSONData(data) {
					completion(true, repo)
				} else {
					completion(false, .None)
				}
			}
		})
		task.resume()
	}
}
