Assignment 3: Twitter

Developer: Abdur Rehman

Date: September 30, 2014

Description:

The goal of this assignment is to create an iOS Twitter Client App which authenticates using OAuth 1.0a and reads the tweets feed. New tweets can be composed. Existing tweets can be replied to, retweeted, favorited/unfavorited.

Number of Hours Taken: 11

All Required Stores Completed:

- User can sign in using OAuth 1.0a login flow
- User can view last 20 tweets from their home timeline
- The current signed in user will be persisted across restarts
- In the home timeline, user can view tweets with the user profile picture, username, tweet text, and timestamp. 
- User can pull to refresh
- User can compose a new tweet by tapping on the NEW button.
- User can tap on a tweet to view it, with controls to retweet, favorite/unfavorite, and reply.

Optional Stories:
- Optional: Retweeting and favoriting increments the retweet and favorite count.
- Optional: User is able to unfavorite and it decrements the unfavorite count.
- Optional: Replies are prefixed with the username

Known Issues:

- Un-Retweet Not implemented
- If a user has retweeted a tweet, the user's and name show up with the RT @ tweet.
- If a tweet has been retweeted, the cell does not add dynamic constraints

Installation:

- Run "pod install" on the command line 
- Build on Xcode 6 GM and deploy on iPhone 5 / 5S / 6 / 6Plus

Open Source Libraries:

- AFNetworking
- BDBOAuth1Manager
- NSDateMinimalTimeAgo
- JGProgressHUD

GIF (created using LiceCAP): 

![TwitterGIF-AbdurR.gif](https://github.com/abdurp/ATwitter/blob/master/TwitterGIF-AbdurR.gif)
