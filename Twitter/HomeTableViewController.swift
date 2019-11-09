//
//  HomeTableViewController.swiftt
//  Twitter
//
//  Created by Nathan Ireland on 11/1/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numbOfTweets = 0
    
    
    let myRefreshControl = UIRefreshControl()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        
        tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    @objc func loadTweet(){
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": 10]
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: params, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll();
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("could not retrieve tweets")
        })
    }

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userToken")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as!  NSDictionary
        
        cell.userNameLbl.text = user["name"] as? String
        cell.tweetLbl.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageURL =  URL(string: (user["profile_image_url_https"] as? String)!)
        
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data{
            cell.profileImage.image = UIImage(data: imageData)
        }
        
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = (tweetArray[indexPath.row]["id"] as! Int)
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }


}
