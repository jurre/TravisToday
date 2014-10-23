//
//  TokenService.swift
//  Travis
//
//  Created by Jurre Stender on 23/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation


class TokenService: BaseService {
	func fetchToken(completion: (Bool, String?) -> Void) {
		if let cachedToken = TokenCache.get() {
			completion(true, cachedToken)
		} else {
			let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
				if (error != nil) {
					println(error.localizedDescription)
					completion(false, .None)
				} else {
					let encodedResponse = NSString(data: data!, encoding: NSUTF8StringEncoding)
					if let token = self.parseToken(data!) {
						completion(true, token)
					} else {
						completion(false, .None)
					}
				}
			})
			task.resume()
		}
	}
	
	private var request: NSMutableURLRequest {
		let request = self.request(NSURL(string: "https://api.travis-ci.com/auth/github")!)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		let body = "{\"github_token\": \"\(GITHUB_TOKEN)\"}"
		request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
		request.HTTPMethod = "POST"
		return request
	}
	
	private func parseToken(data: NSData) -> String? {
		var error: NSError?
		let jsonOptional: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error)
		
		if let json = jsonOptional as? Dictionary<String, AnyObject> {
			if let token = json["access_token"] as? String {
				return	"token \(token)"
			}
		}
		return .None
	}
}

//TODO: Keychain
let _TokenCacheKey = "TravisToday.CachedToken"

class TokenCache {
	class func get() -> NSString? {
		if let data = NSUserDefaults.standardUserDefaults().objectForKey(_TokenCacheKey) as? NSData {
			if let token = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? String {
				return token
			}
		}
		return .None
	}
	
	class func set(newToken: String?) -> Void {
		let userDefaults = NSUserDefaults.standardUserDefaults()
		if let token = newToken {
			let data = NSKeyedArchiver.archivedDataWithRootObject(token)
			userDefaults.setObject(data, forKey: _TokenCacheKey)
		} else {
			userDefaults.removeObjectForKey(_TokenCacheKey)
		}
	}
}