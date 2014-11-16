//
//  RepoConfig.swift
//  Travis
//
//  Created by Jurre Stender on 23/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

struct RepoConfig {
	enum Access {
		case Public
		case Private
	}

	let slug: String
	let access: Access

	private var baseUrl: String {
		switch access {
		case .Public:
			return "https://api.travis-ci.org/repos/"
		case .Private:
			return "https://api.travis-ci.com/repos/"
		}
	}

	var url: NSURL {
		return NSURL(string: baseUrl + slug)!
	}
}