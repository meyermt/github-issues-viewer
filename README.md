# GitHub Issues Viewer
App for viewing issues in a GitHub repo.

## Overview

Basic Tab Bar Controller Application for viewing GitHub issues on the Summer Forum repo. Has the following tabs/functionality:

**Open Issues** First tab, table view which shows all open issues, including title, person who opened, and the date created.

**All Issues** Second tab, table view shows all issues, also including title, person who opened, and the date created.

**Status** Third tab, overall status tab which shows total number of opened and closed issues.

In the first two tabs, any issue in the table can be clicked on and will present the original post.

## Attributions

Can also be found in code, but for quick reference:

* IssueTableViewController.swift
  * [UIRefreshControl info](https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view/)
* CircleViewController.swift
  * [Making a Circle](https://stackoverflow.com/questions/40555462/how-to-draw-a-circle-in-swift-3)
* IssueDetailViewController.swift
  * [Opening Link in Safari](https://stackoverflow.com/questions/31628246/make-button-open-link-swift)
  * [Opening a Link post iOS 10](https://useyourloaf.com/blog/openurl-deprecated-in-ios10/)
* GitHubClient.swift
  * [General Closure Help](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html)
  * [General DateFormatter Help](https://developer.apple.com/documentation/foundation/dateformatter)
  * [General ISO8601DateFormatter Help](https://developer.apple.com/documentation/foundation/iso8601dateformatter)
* Issue.swift
  * No link, but referenced much of FoodTracker for this
