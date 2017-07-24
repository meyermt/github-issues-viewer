//
//  IssueTableViewCell.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/22/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var issueTitle: UILabel!
    @IBOutlet weak var issueOwner: UILabel!
    @IBOutlet weak var issueTime: UILabel!
    
    // MARK: Base Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
