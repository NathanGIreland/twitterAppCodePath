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
    @IBOutlet weak var timelbl: UILabel!
    
    @IBOutlet weak var retweetBtn: UIButton!
    
    @IBOutlet weak var heartBtn: UIButton!
    
    @IBAction func retweeted(_ sender: Any) {
    }
    
    @IBAction func hearted(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("favorite couldnt be completet \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("unfavorite couldnt be completet \(error)")
            })
        }
    }
    
    var favorited: Bool = false
    var tweetId: Int = -1
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            heartBtn.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }else{
            heartBtn.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
