//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Matthew Nguyen on 9/29/22.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweenButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited : Bool = false
    var tweetId: Int = -1 // set as -1 to know its not set
    var retweeted: Bool = false
    
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        if (favorited) {
            favButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited // lets you know if it needs to be favorited or not
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error: Error) in
                print("Favorite did not succeed \(error)")
            })
        }
        else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error: Error) in
                print("Unfavorite did not succeed \(error)")
            })
        }
        
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        if (isRetweeted) {
            retweenButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweenButton.isEnabled = false
        }
        else {
            retweenButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweenButton.isEnabled = true
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (error: Error) in
            print("Error in retweet \(error)")
        })
        
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
