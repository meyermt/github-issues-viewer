//
//  CircleViewController.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/23/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController {
    
    // MARK: Properties
    
    var allIssues = [Issue]()
    let gitHubClient = GitHubClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadIssues()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Private methods
    
    @objc private func loadIssues() {
        func populateAllIssues(_ issues: [Issue]) {
            self.allIssues = issues
            self.drawCircle()
        }
        gitHubClient.requestIssues(state: "all", completion: populateAllIssues(_:))
    }
    
    // - Attributions: https://stackoverflow.com/questions/40555462/how-to-draw-a-circle-in-swift-3
    private func drawCircle() {
        
        let colorArray: [UIColor] = [UIColor.green, UIColor.white, UIColor.red, UIColor.white]
        var x = 300.0
        var y = 300.0
        
        colorArray.forEach { color in
            let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: x, height: y))
        
            circle.center = self.view.center
            circle.layer.cornerRadius = CGFloat(x / 2)
            circle.backgroundColor = color
            circle.clipsToBounds = true
            self.view.addSubview(circle)
            x -= 20
            y -= 20
        }
        
        var openIssues = 0
        var closedIssues = 0
        
        self.allIssues.forEach { issue in
            if (issue.status == .open) {
                openIssues += 1
            } else {
                closedIssues += 1
            }
        }
        
        let labelTextOpen = "\(openIssues) Open Issues"
        setUpLabel(text: labelTextOpen, color: .red, y: 275.0)
        let labelTextClosed = "\(closedIssues) Closed Issues"
        setUpLabel(text: labelTextClosed, color: .green, y: 375.0)
    }
    
    private func setUpLabel(text: String, color: UIColor, y: Double) {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        label.text = text
        label.font = label.font.withSize(40)
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.center = CGPoint(x: 187.5, y: y)
        label.textColor = color
        label.isHidden = false
        
        self.view.addSubview(label)
    }
    
}
