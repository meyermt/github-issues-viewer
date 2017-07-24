//
//  AllIssueTableViewCell.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/23/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class AllIssueTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueOwner: UILabel!
    @IBOutlet weak var issueTime: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: Base methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
