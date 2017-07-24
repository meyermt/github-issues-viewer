//
//  IssueDetailViewController.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/23/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class IssueDetailViewController: UIViewController {
    
    // MARK: Properties
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueOwner: UILabel!
    @IBOutlet weak var issueTime: UILabel!
    @IBOutlet weak var issueState: UILabel!
    @IBOutlet weak var issuePost: UITextView!
    
    var issue: Issue?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let issue = issue {
            let statusString = String(describing: issue.status)
            iconImageView.image = UIImage(named: statusString)
            issueTitle.text = issue.title
            issueOwner.text = issue.owner
            issueTime.text = issue.createdAt
            issueState.text = "Status: \(statusString)"
            issueState.textColor = statusString == "open" ? UIColor.green : UIColor.red
            issuePost.text = issue.post
        }
        issueTitle.lineBreakMode = .byWordWrapping
        issueTitle.numberOfLines = 0
        issuePost.isEditable = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Actions
 
    // - Attributions: https://stackoverflow.com/questions/31628246/make-button-open-link-swift
    // - Attributions: https://useyourloaf.com/blog/openurl-deprecated-in-ios10/
    @IBAction func goToLink(_ sender: UIBarButtonItem) {
        if let url = URL(string: issue!.link){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
}
