//
//  HomeViewController.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 01/08/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    let hmmEndpoint = "https://api.thingspeak.com/channels/1419598/feeds.json?api_key=SWN0URWO02UU9SAS"
    var arrayResponseFromJSON:[ThingSpeakField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Smart Farm"
        // Do any additional setup after loading the view.
    }
    

    fileprivate func callApiFromThingSpeak(){
        ApiUtil.getRequest(viewController: self, endpoint: hmmEndpoint, customError: false, jsonHandler: {
            response in
            let totalResponse = response.value as? [String:Any]
            let channel = totalResponse?["channel"] as? [String:Any]
            let field1 = channel?["field1"] as? String
            let field2 = channel?["field2"] as? String
            let field3 = channel?["field3"] as? String
            let field4 = channel?["field4"] as? String
            
            let feeds = totalResponse?["feeds"] as? NSArray
            if let feeds = feeds{
                for oneFeed in feeds{
                    
                }
            }
            

            
        }, onFailure: {})
    }

}
