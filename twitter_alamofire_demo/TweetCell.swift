//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var retweetIcon: UIButton!
    
    
    @IBAction func retweetButton(_ sender: Any) {
        
        if retweetIcon.isSelected {
            retweetIcon.isSelected = false
            print("unretweeted")
        }
        
        else {
            retweetIcon.isSelected = true
            print("retweet")
        }
        
    }
    
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favoriteIcon: UIButton!
    
    
    
    @IBAction func favoriteButton(_ sender: Any) {
        
        if favoriteIcon.isSelected {
            favoriteIcon.isSelected = false
            print("favorited")
        }
            
        else {
            favoriteIcon.isSelected = true
            print("unfavorited")
        }
        
    }
    
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            dateLabel.text = tweet.createdAtString
            nameLabel.text = tweet.user.name
            usernameLabel.text = tweet.user.screenName
            let profileURL = tweet.user.profileURL
            profileImageView.af_setImage(withURL: profileURL!)
            profileImageView.layer.cornerRadius = 25
            profileImageView.clipsToBounds = true

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
