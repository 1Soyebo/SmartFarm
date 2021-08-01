//
//  HomeViewController.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 01/08/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    let hmmEndpoint = "https://api.thingspeak.com/channels/1419598/feeds.json?api_key=SWN0URWO02UU9SAS"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Smart Farm"
        // Do any additional setup after loading the view.
    }
    

    fileprivate func callApiFromThingSpeak(){
        ApiUtil.getRequest(viewController: self, endpoint: hmmEndpoint, customError: false, jsonHandler: {
            response in
            let k = response.value as? [String:Any]
            
        }, onFailure: {})
    }

}
