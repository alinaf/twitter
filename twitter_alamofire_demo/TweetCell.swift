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
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            dateLabel.text = tweet.createdAtString
            nameLabel.text = tweet.user.name
            usernameLabel.text = tweet.user.screenName
            let profileURL = tweet.user.profileURL
            profileImageView.af_setImage(withURL: profileURL!)
            //posterImageView.af_setImage(withURL: posterURL!)
            

        }
    }

    
    var user: User! {
        didSet {

            nameLabel.text = user.name
            usernameLabel.text = user.screenName
            
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
