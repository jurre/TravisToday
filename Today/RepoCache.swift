//
//  RepoCache.swift
//  Travis
//
//  Created by Jurre Stender on 22/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

class RepoCache {
	private let userDefaults = NSUserDefaults.standardUserDefaults()

	func get(key: String) -> Repo? {
		if let data = userDefaults.objectForKey(key) as? NSData {
			let repo = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? Repo
			return repo
		}

		return .None
	}

	func set(repo: Repo, forKey: String) -> Void {
		let data = NSKeyedArchiver.archivedDataWithRootObject(repo)
		userDefaults.setObject(data, forKey: forKey)
	}
}