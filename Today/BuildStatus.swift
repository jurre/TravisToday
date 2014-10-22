//
//  File.swift
//  TravisToday
//
//  Created by Jurre Stender on 20/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Foundation

enum BuildStatus {
	case Running
	case Passed
	case Failed
	case Unknown

	var stringValue: String {
		switch self {
		case Running:
			return "running"
		case Passed:
			return "passed"
		case Failed:
			return "failed"
		default:
			return "unknown"
		}
	}

	static func fromString(status: String) -> BuildStatus {
		switch status {
		case "running":
			return BuildStatus.Running
		case "passed":
			return BuildStatus.Passed
		case "failed":
			return BuildStatus.Failed
		default:
			return BuildStatus.Unknown
		}
	}
}