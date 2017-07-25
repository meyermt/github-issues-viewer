//
//  ActivityTableViewCell.swift
//  GitHub Issues Viewer
//
//  Created by Michael Meyer on 7/24/17.
//  Copyright © 2017 Michael Meyer. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var avatarIcon: UIImageView!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var issuesOpened: UILabel!
    
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
