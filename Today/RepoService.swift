//
//  RepoService.swift
//  Travis
//
//  Created by Jurre Stender on 22/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

class BaseService {
	let accept = "application/vnd.travis-ci.2+json"

	func request(url: NSURL) -> NSMutableURLRequest {
		let request = NSMutableURLRequest(URL: url)
		request.setValue(accept, forHTTPHeaderField: "Accept")
		return request
	}
}

class RepoService: BaseService {

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
	
	func find(repo: RepoConfig, completion: (Bool, Repo?) -> Void) {
		let request = self.request(repo.url)
		
		let fetchRepo = {() -> Void in
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
		
		if (repo.access == .Private) {
			TokenService().fetchToken({ (success, token) -> Void in
				if (success) {
					request.setValue(token!, forHTTPHeaderField: "Authorization")
					fetchRepo()
				} else {
					println("Error fetching token")
					completion(false, .None)
				}
			})
		} else {
			fetchRepo()
		}
	}
}
