//
//  StatusIcon.swift
//  TravisToday
//
//  Created by Jurre Stender on 19/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Cocoa

extension BuildStatus {
	var color: CGColorRef {
		switch self {
		case .Passed:
			return NSColor.greenColor().CGColor
		case .Running:
			return NSColor.yellowColor().CGColor
		case .Failed:
			return NSColor.redColor().CGColor
		case .Unknown:
			return NSColor.grayColor().CGColor
		}
	}
}

class StatusIcon: NSView {
	var status: BuildStatus

	required init?(coder: NSCoder) {
		self.status = .Unknown
		super.init(coder: coder)
		self.wantsLayer = true
		self.needsDisplay = true
	}

	required override init(frame: CGRect) {
		self.status = .Unknown
		super.init(frame: frame)
		self.wantsLayer = true
		self.needsDisplay = true
	}

	override func drawRect(dirtyRect: NSRect) {
		self.layer?.cornerRadius = self.frame.size.height / 2
		self.layer?.backgroundColor = self.status.color
		super.drawRect(dirtyRect)
	}
}