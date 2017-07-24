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
        
        
        gitHubClient.requestIssues(state: "all") { (issues: [Issue]) in
            populateAllIssues(issues)
        }
    }
    
    // - Attributions: https://stackoverflow.com/questions/40555462/how-to-draw-a-circle-in-swift-3
    private func drawCircle() {
        
        //let circleView = UIView()
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
        
        let labelText = "\(openIssues) Open Issues \(closedIssues) Closed Issues"
        print("open issues: \(openIssues)")
        
        let label = UILabel()
        label.text = labelText
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.center = self.view.center
        label.textColor = .red
        
        self.view.addSubview(label)
    }
    
}
