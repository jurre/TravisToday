//
//  Repo.swift
//  TravisToday
//
//  Created by Jurre Stender on 20/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

class Repo: NSObject {
	var slug: String?
	var buildNumber: String?
	var duration: Int?
	var status: BuildStatus?
	var finishedAt: String?

	init(slug: String, buildNumber: String, duration: Int, status: String, finishedAt: String) {
		super.init()
		self.slug = slug
		self.buildNumber = buildNumber
		self.duration = duration
		self.status = BuildStatus.fromString(status)
		self.finishedAt = finishedAt
	}
}
