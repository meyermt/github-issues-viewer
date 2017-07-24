//
//  Issue.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/22/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit
import os.log

class Issue: NSObject, NSCoding {
    
    // MARK: Properties
    
    var title: String
    var owner: String
    var createdAt: String
    var status: GitHubStatus
    var post: String
    var link: String
    
    enum GitHubStatus {
        case open
        case closed
    }
    
    //MARK: Types
    
    struct PropertyKey {
        static let title = "title"
        static let owner = "owner"
        static let createdAt = "createdAt"
        static let status = "status"
        static let post = "post"
        static let link = "link"
    }
    
    //MARK: Initialization
    
    init?(title: String, owner: String, createdAt: String, status: GitHubStatus, post: String, link: String) {
        
        self.title = title
        self.owner = owner
        self.createdAt = createdAt
        self.status = status
        self.post = post
        self.link = link
    }
    
    //MARK: NSCoding
    // - Atribution: See previous FoodTracker assignment
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(owner, forKey: PropertyKey.owner)
        aCoder.encode(createdAt, forKey: PropertyKey.createdAt)
        aCoder.encode(status, forKey: PropertyKey.status)
        aCoder.encode(post, forKey: PropertyKey.post)
        aCoder.encode(post, forKey: PropertyKey.link)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String
        
        let owner = aDecoder.decodeObject(forKey: PropertyKey.owner) as? String
        
        let createdAt = aDecoder.decodeObject(forKey: PropertyKey.createdAt) as? String
        
        let status = aDecoder.decodeObject(forKey: PropertyKey.status) as? GitHubStatus
        
        let post = aDecoder.decodeObject(forKey: PropertyKey.post) as? String
        
        let link = aDecoder.decodeObject(forKey: PropertyKey.post) as? String
        
        self.init(title: title!, owner: owner!, createdAt: createdAt!, status: status!, post: post!, link: link!)
    }
    
}
