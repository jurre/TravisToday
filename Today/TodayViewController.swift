//
//  TodayViewController.swift
//  Travis
//
//  Created by Jurre Stender on 19/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Cocoa
import NotificationCenter

class TodayViewController: NSViewController, NCWidgetProviding, NCWidgetListViewDelegate {

    @IBOutlet var listViewController: NCWidgetListViewController!

    // MARK: - NSViewController
	let repos: NSArray = [
		Repo(slug: "DefactoSoftware/Hours",
			buildNumber: "2345",
			duration: "Duration: 1 min 6 sec",
			status: "passed",
			finishedAt: "Finished: 4 minutes ago"),
		Repo(slug: "DefactoSoftware/LearningSpaces",
			buildNumber: "2231",
			duration: "Duration: 43 sec",
			status: "running",
			finishedAt: "Finished: -"),
		Repo(slug: "DefactoSoftware/Conversations",
			buildNumber: "1372",
			duration: "Duration: 1 min 23 sec",
			status: "failed",
			finishedAt: "Finished: about 1 hour ago")
	]

	override var nibName: String? {
		return "TodayViewController"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Set up the widget list view controller.
		// The contents property should contain an object for each row in the list.
		self.listViewController.contents = repos
	}
	
	
	// MARK: - NCWidgetProviding
	
	func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		// Refresh the widget's contents in preparation for a snapshot.
		// Call the completion handler block after the widget's contents have been
		// refreshed. Pass NCUpdateResultNoData to indicate that nothing has changed
		// or NCUpdateResultNewData to indicate that there is new data since the
		// last invocation of this method.
		completionHandler(.NoData)
	}
	
	func widgetMarginInsetsForProposedMarginInsets(var defaultMarginInset: NSEdgeInsets) -> NSEdgeInsets {
		// Override the left margin so that the list view is flush with the edge.
		defaultMarginInset.left = 0
		return defaultMarginInset
	}
	
	var widgetAllowsEditing: Bool {
		// Return true to indicate that the widget supports editing of content and
		// that the list view should be allowed to enter an edit mode.
		return false
	}
	
	// MARK: - NCWidgetListViewDelegate
	
	func widgetList(list: NCWidgetListViewController!, viewControllerForRow row: Int) -> NSViewController! {
		// Return a new view controller subclass for displaying an item of widget
		// content. The NCWidgetListViewController will set the representedObject
		// of this view controller to one of the objects in its contents array.
		let repo: AnyObject = repos[row]
		let repoController = ListRowViewController()
		repoController.repo = repo as? Repo
		return repoController
	}
	
	func widgetList(list: NCWidgetListViewController!, shouldReorderRow row: Int) -> Bool {
		// Return true to allow the item to be reordered in the list by the user.
		return false
	}
	
	func widgetList(list: NCWidgetListViewController!, shouldRemoveRow row: Int) -> Bool {
		// Return true to allow the item to be removed from the list by the user.
		return false
	}
}
