//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Alina Abidi on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
var tweets: [Tweet] = []
   var user = User.current
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        usernameLabel.text = user?.name
        handleLabel.text = user?.screenName

        var count = user?.friends_count
        var text = String(describing: count!)
        followingLabel.text = text + " Following"
        
        count = user?.followers_count
        text = String(describing: count!)
        followersLabel.text = text + " Followers"
        
        bioLabel.text = user?.bio
        locationLabel.text = user?.location
        
        let profileURL = user?.profileURL
        profileView.af_setImage(withURL: profileURL!)
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        profileView.clipsToBounds = true
        profileView.layer.borderColor = UIColor.white.cgColor
        profileView.layer.borderWidth = 5
        
    let backgroundURL = user?.backgroundURL
      backgroundView.af_setImage(withURL: backgroundURL!)
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 200
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 100

    
        APIManager.shared.getUserTweets(screenName: user?.screenName) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
    }
    


    
    func refreshControlAction(_ refreshControl: UIRefreshControl){
        APIManager.shared.getUserTweets(screenName: user?.screenName) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting my tweets: " + error.localizedDescription)
            }
        }
        refreshControl.endRefreshing()
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        
        cell.tweet = tweets[indexPath.row]
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
