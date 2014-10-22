//
//  TodayViewController.swift
//  Travis
//
//  Created by Jurre Stender on 19/10/14.
//  Copyright (c) 2014 jurre. All rights reserved.
//

import Cocoa
import NotificationCenter
import TravisKit

extension Repo {
	var durationLabel: String {
		get {
			let seconds = self.duration! % 60
			let minutes = (self.duration! - seconds) / 60
			return "Duration: \(minutes) min \(seconds) sec"
		}
	}
}

class TravisViewController: NSViewController, NCWidgetProviding, NCWidgetListViewDelegate {

    // MARK: - NSViewController

    @IBOutlet var listViewController: NCWidgetListViewController!

	var repos: NSMutableArray = []

	override var nibName: String? {
		return "TravisViewController"
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		// Set up the widget list view controller.
		// The contents property should contain an object for each row in the list.
		for slug in PUBLIC_REPOS {
			if let repo = RepoCache().get(slug) {
				self.repos.addObject(repo)
			}
			self.listViewController.contents = self.repos
		}
	}
	
	
	// MARK: - NCWidgetProviding
	
	func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
		self.repos.removeAllObjects()
		for slug in PUBLIC_REPOS {
			RepoService.sharedService.find(slug, completion: { (success: Bool, repo: Repo?) -> Void in
				if (success) {
					RepoCache().set(repo!, forKey: slug)
					dispatch_async(dispatch_get_main_queue(), { () -> Void in
						self.repos.addObject(repo!)
						completionHandler(.NewData)
					})
				} else {
					println("Error fetching " + slug)
						completionHandler(.NoData)
				}
			})
		}
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
