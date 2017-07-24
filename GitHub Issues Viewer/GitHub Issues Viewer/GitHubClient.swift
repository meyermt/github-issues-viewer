//
//  GitHubClient.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/22/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class GitHubClient {
    
    // MARK: Properties
    
    let baseUrlString = "https://api.github.com/repos/uchicago-mobi/mpcs51030-2017-summer-forum/issues?state="
    var json = [[String: AnyObject]]()
    var ghIssues = [Issue]()
    
    // MARK: Actions
    
    // - Attributions: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Closures.html
    func requestIssues(state: String, completion: @escaping ((_ issues: [Issue]) -> Void)) {
        let urlString = baseUrlString + state
        guard let url = NSURL(string: urlString) else {
            fatalError("Unable to create NSURL from string")
        }
        
        let session = URLSession.shared
        
        print("about to make call to \(urlString)")
        let task = session.dataTask(with: url as URL, completionHandler: { (data, response, error) -> Void in
            print("made call")
            
            //print("Response: \(String(describing: response))")
            
            guard ((response as! HTTPURLResponse).statusCode == 200) else {
                fatalError("Received bad response from server")
            }
            
            guard error == nil else {
                fatalError("Error: \(error!.localizedDescription)")
            }
            
            print("Raw data: \(String(describing: data))")
            var testString = ""
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                //print(json)
                
                guard let issues = json as? [[String: AnyObject]] else {
                    fatalError("We couldn't cast the JSON to an array of dictionaries")
                }
                
                testString = issues[0]["title"] as! String
                print(testString)
                // Parse the array of dictionaries to get the important information that you
                // need to present to the user
                
                // - Attributions: https://developer.apple.com/documentation/foundation/dateformatter
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .medium
                
                // - Attributions: https://developer.apple.com/documentation/foundation/iso8601dateformatter
                let isoFormatter = ISO8601DateFormatter()
                
                // Do some parsing here
                DispatchQueue.main.async {
                    
                    self.ghIssues = issues.map {
                        var issue = $0
                        let status = issue["state"] as! String == "open" ? Issue.GitHubStatus.open : Issue.GitHubStatus.closed
                        
                        let date = isoFormatter.date(from: issue["created_at"] as! String)
                        let dateString = formatter.string(from: date!)
                        return Issue(title: issue["title"] as! String, owner: issue["user"]?["login"] as! String, createdAt: dateString, status: status, post: issue["body"] as! String, link: issue["html_url"] as! String)!
                    }
                    completion(self.ghIssues)
                }
                
            } catch {
                fatalError("error serializing JSON: \(error)")
            }
                        

        })
        task.resume()
        //return gitHubInfo
    }
}
