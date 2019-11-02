//
//  tweetTableViewCell.swift
//  Twitter
//
//  Created by Nathan Ireland on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class tweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    
    @IBOutlet weak var tweetLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
