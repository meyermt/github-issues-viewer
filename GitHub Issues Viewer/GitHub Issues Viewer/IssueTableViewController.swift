//
//  IssueTableViewController.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/20/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class IssueTableViewController: UITableViewController {
    
    // MARK: Properties
    
    var openIssues = [Issue]()
    let gitHubClient = GitHubClient()
    let openIcon = UIImage(named: "open")

    // MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = self.refreshControl
        // - Attributions: https://cocoacasts.com/how-to-add-pull-to-refresh-to-a-table-view-or-collection-view/
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl?.attributedTitle = NSAttributedString(string: "Fetching Latest Issues ...")
        self.refreshControl?.addTarget(self, action: #selector(loadIssues), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadIssues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private methods
    
    @objc private func loadIssues() {
        func populateOpenIssues(_ issues: [Issue]) {
            self.openIssues = issues
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        
        
        gitHubClient.requestIssues(state: "open") { (issues: [Issue]) in
            populateOpenIssues(issues)
        }
    }
    
    // MARK: Table view overrides
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openIssues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "IssueTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? IssueTableViewCell else {
            fatalError("The dequeued cell is not an instance of IssueTableViewCell.")
        }

        
        let issue = openIssues[indexPath.row]
        
        cell.issueOwner.text = issue.owner
        cell.issueTime.text = issue.createdAt
        cell.issueTitle.text = issue.title
        cell.iconImageView.image = openIcon
        
        return cell
    }
    
    // MARK: Navigation Overrides
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "ShowDetail":
            guard let issueDetailViewController = segue.destination as? IssueDetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedIssueCell = sender as? IssueTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedIssueCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedIssue = openIssues[indexPath.row]
            issueDetailViewController.issue = selectedIssue
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

}

