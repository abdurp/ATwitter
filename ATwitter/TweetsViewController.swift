//
//  TweetsViewController.swift
//  ATwitter
//
//  Created by admin on 9/27/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var tweetsTableView: UITableView!
    var tweets: [Tweet]! = [Tweet]()
    var refreshControl:UIRefreshControl!
    var HUD = JGProgressHUD(style: JGProgressHUDStyle.Light)
    
    func refresh(sender:AnyObject)
    {
        getTweets()
        self.tweetsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HUD.textLabel.text = "Loading Tweets.."
        HUD.showInView(self.view)
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.25, green: 0.6, blue: 1.0, alpha: 0.0)
        

        tweetsTableView.delegate = self
        tweetsTableView.dataSource = self
        
        
        getTweets()
        
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "reloadTweets", userInfo: nil, repeats: false)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tweetsTableView.insertSubview(refreshControl, aboveSubview: self.tweetsTableView)
        
        HUD.dismissAfterDelay(4)
        
        tweetsTableView.estimatedRowHeight = UITableViewAutomaticDimension
        
        //tweetsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tweetsTableView.reloadData()
    }
    
    func getTweets()
    {
        TwitterClient.sharedInstance.getTimelineWithCompletion({(tweets, error) -> () in
            
            self.tweets = tweets
        })
        
        self.tweetsTableView.reloadData()
    }
    
    func reloadTweets()
    {
        self.tweetsTableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogout(sender: AnyObject) {
        
        User.currentUser?.logout()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
        
        cell.contentView.layoutSubviews()
        
        if tweets?.count != 0 {
            var tweet = tweets[indexPath.row] as Tweet!
        
            if tweet != nil {
                cell.nameLabel.text = tweet.user?.name
                cell.handleLabel.text = "@\(tweet.user!.screenName!)"
                cell.tweetTextLabel.text = tweet.text
                cell.postedAtLabel.text = tweet.creationDate?.timeAgo()
                
                if tweet.user?.profileImageUrl != nil {
                    cell.profileView.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
                }
                
                cell.replyView.setImageWithURL(NSURL(string: replyImageURL))
                cell.retweetView.setImageWithURL(NSURL(string: retweetImageURL))
                if tweet.retweetCount == "0" {
                    cell.retweetCountLabel.hidden = true
                }
                else {
                    cell.retweetCountLabel.hidden = false
                    cell.retweetCountLabel.text = tweet.retweetCount
                    
                }
                
                cell.favoriteImageView.setImageWithURL(NSURL(string: favoriteImageURL))
                if tweet.favoriteCount == "0" {
                    cell.favoriteCountLabel.hidden = true
                }
                else {
                    cell.favoriteCountLabel.hidden = false
                    cell.favoriteCountLabel.text = tweet.favoriteCount
                }

            }


        }
        
        
        return cell
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
    
        if segue.identifier == "detailSegue" {
            
            let tweetDetailVC = segue.destinationViewController.viewControllers![0] as TweetDetailViewController
            var row = self.tweetsTableView.indexPathForSelectedRow()?.row
            tweetDetailVC.tweet = tweets[row!]
            tweetDetailVC.navigationController?.navigationBar.tintColor = UIColor(red: 0.25, green: 0.6, blue: 1.0, alpha: 0.0)
        }


    }


}
