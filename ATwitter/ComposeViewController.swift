//
//  ComposeViewController.swift
//  ATwitter
//
//  Created by admin on 9/29/14.
//  Copyright (c) 2014 abdi. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var tweetArea: UITextView!
    
    var replyUserName: String!
    
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = User.currentUser?.name
        handleLabel.text = User.currentUser?.screenName
        
        if replyUserName != nil{
            tweetArea.text = "@\(replyUserName)"
        }
        
        if User.currentUser?.profileImageUrl != nil {
            profileView.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        
        TwitterClient.sharedInstance.postTweetWithCompletion(tweetArea.text!, {(error) -> () in
            if error == nil {
                println("Tweet POsted successfully")
            }
        })
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
