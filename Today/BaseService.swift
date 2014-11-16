//
//  BaseService.swift
//  Travis
//
//  Created by Jurre Stender on 16/11/14.
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
