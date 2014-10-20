//
//  ListRowViewController.swift
//  Travis
//
//  Created by Jurre Stender on 19/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Cocoa

class ListRowViewController: NSViewController {
	var repo: Repo?
	@IBOutlet weak var statusIcon: StatusIcon!

    override var nibName: String? {
        return "ListRowViewController"
    }

    override func loadView() {
        super.loadView()
    }

	override func viewDidLoad() {
		super.viewDidLoad()

		if let status = repo?.status {
			statusIcon.status = status
		}
	}
}
