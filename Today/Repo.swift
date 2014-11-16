//
//  Repo.swift
//  TravisToday
//
//  Created by Jurre Stender on 20/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

class Repo: NSObject, NSCoding {

	enum Access {
		case Public
		case Private
	}

	var slug: String?
	var buildNumber: String?
	var duration: Int?
	var status: BuildStatus?
	var finishedAt: String?
	var access: Access?

	init(slug: String, access: Access) {
		super.init()
		self.slug = slug
		self.access = access
	}
	
	init(slug: String, buildNumber: String, duration: Int, status: String, finishedAt: String) {
		super.init()
		self.slug = slug
		self.buildNumber = buildNumber
		self.duration = duration
		self.status = BuildStatus.fromString(status)
		self.finishedAt = finishedAt
	}
	
	// MARK: NSCoding

	required init(coder: NSCoder) {
		let statusString = coder.decodeObjectForKey(Encoding.Status) as? String
		
		slug = coder.decodeObjectForKey(Encoding.Slug) as? String
		buildNumber = coder.decodeObjectForKey(Encoding.BuildNumber) as? String
		duration = coder.decodeObjectForKey(Encoding.Duration) as? Int
		status = BuildStatus.fromString(statusString!)
		finishedAt = coder.decodeObjectForKey(Encoding.FinishedAt) as? String
	}
	
	func encodeWithCoder(coder: NSCoder) {
		let statusString = status?.stringValue
		
		coder.encodeObject(slug, forKey: Encoding.Slug)
		coder.encodeObject(buildNumber, forKey: Encoding.BuildNumber)
		coder.encodeObject(duration, forKey: Encoding.Duration)
		coder.encodeObject(statusString, forKey: Encoding.Status)
		coder.encodeObject(finishedAt, forKey: Encoding.FinishedAt)
	}

	var url: NSURL {
		return NSURL(string: baseUrl + slug!)!

	}

	// MARK: Private

	private var baseUrl: String {
		switch access! {
		case .Public:
			return "https://api.travis-ci.org/repos/"
		case .Private:
			return "https://api.travis-ci.com/repos/"
		}
	}

	private struct Encoding {
		static let Slug = "Slug"
		static let BuildNumber = "BuildNumber"
		static let Duration = "Duration"
		static let Status = "Status"
		static let FinishedAt = "FinishedAt"
	}
}
