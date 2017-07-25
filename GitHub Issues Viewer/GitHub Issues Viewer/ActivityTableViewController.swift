//
//  ActivityTableViewController.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/24/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class ActivityTableViewController: UITableViewController {

    // MARK: Properties
    
    var allIssues = [Issue]()
    var masterOwnersToIssues = [(key: String, value: Int)]()
    let gitHubClient = GitHubClient()
    
    // MARK: Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = self.refreshControl
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
        func populateAllIssues(_ issues: [Issue]) {
            self.allIssues = issues
            self.refreshControl?.endRefreshing()
            var ownersToIssues = [String:Int]()
            for issue in allIssues {
                if (ownersToIssues[issue.owner] != nil) {
                    ownersToIssues[issue.owner] = ownersToIssues[issue.owner]! + 1
                } else {
                    ownersToIssues[issue.owner] = 1
                }
            }
            organizeDict(ownersToIssues)
            self.tableView.reloadData()
        }
        
        gitHubClient.requestIssues(state: "all", completion: populateAllIssues(_:))
    }
    
    private func organizeDict(_ ownersToIssues: [String:Int]) {
        self.masterOwnersToIssues = ownersToIssues.sorted { (first: (key: String, value: Int), second: (key: String, value: Int)) -> Bool in
            first.value > second.value
        }
    }
    
    // MARK: Table view overrides
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.masterOwnersToIssues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ActivityTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ActivityTableViewCell else {
            fatalError("The dequeued cell is not an instance of IssueTableViewCell.")
        }
        
        let user = self.masterOwnersToIssues[indexPath.row]
        cell.user.text = user.key
        cell.issuesOpened.text = " Opened \(user.value) issues"
        
        // admittedly sloppy way to find matching avatar. Could have done it earlier, should fix
        var avatar = ""
        for issue in allIssues {
            if (user.key == issue.owner) {
                avatar = issue.avatar
            }
        }
        
        // - Attributions: https://stackoverflow.com/questions/29472149/swift-how-to-display-an-image-using-url
        if let url = NSURL(string: avatar) {
            if let data = NSData(contentsOf: url as URL) {
                let image = UIImage(data: data as Data)
                cell.avatarIcon.image = image
            }
        }
        return cell
    }

}
