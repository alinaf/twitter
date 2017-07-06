//
//  ProfileCell.swift
//  twitter_alamofire_demo
//
//  Created by Alina Abidi on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import DateToolsSwift

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
// buttons and stuff
    
    @IBOutlet weak var retweetIcon: UIButton!
    @IBOutlet weak var favoriteIcon: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    
    
    //actions
    
    @IBAction func retweetAction(_ sender: Any) {
        
        
        if retweetIcon.isSelected {
            retweetIcon.isSelected = false
            let currentNum = Int(retweetLabel.text!)
            retweetLabel.text = String(currentNum! - 1)
            
            if retweetLabel.text == "0"
            {
                retweetLabel.text = ""
            }
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            print("unretweeted")
        }
            
        else {
            
            
            retweetIcon.isSelected = true
            
            if retweetLabel.text == "" // for 0
            {
                retweetLabel.text = "1"
            }
            else {
                let currentNum = Int(retweetLabel.text!)
                retweetLabel.text = String(currentNum! + 1)
            }
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            print("retweet")
            
        }

    }
    
    
    @IBAction func favoriteAction(_ sender: Any) {
        
        if favoriteIcon.isSelected {
            
            
            favoriteIcon.isSelected = false
            let currentNum = Int(favoriteLabel.text!)
            favoriteLabel.text = String(currentNum! - 1)
            
            if favoriteLabel.text == "0"
            {
                favoriteLabel.text = ""
            }
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            print("unfavorited")
        }
            
        else {
            
            favoriteIcon.isSelected = true
            if favoriteLabel.text == "" // for 0
            {
                favoriteLabel.text = "1"
            }
            else {
                let currentNum = Int(favoriteLabel.text!)
                favoriteLabel.text = String(currentNum! + 1)
            }
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                }   else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
            print("favorited")
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


















var tweet: Tweet! {
    didSet {
        
        print(tweet.text)
        print(tweet.favoriteCount)
        
        favoriteIcon.isSelected = tweet.favorited
        retweetIcon.isSelected = tweet.retweeted
        
        tweetTextLabel.text = tweet.text
        dateLabel.text = tweet.createdAtString
        nameLabel.text = tweet.user.name
        usernameLabel.text = tweet.user.screenName
        
        
        if tweet.retweetCount == 0 {
            retweetLabel.text = ""
        } else {
            retweetLabel.text = String(describing: tweet.retweetCount)
        }
        if tweet.favoriteCount == 0 {
            favoriteLabel.text = ""
        }
        else {
            favoriteLabel.text = String(describing: tweet.favoriteCount)
        }
        
        let profileURL = tweet.user.profileURL
        profileImageView.af_setImage(withURL: profileURL!)
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        
    }
}

}
