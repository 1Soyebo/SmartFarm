//
//  DetailViewController.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 01/08/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var singleThingSpeakhmm: ThingSpeakField?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = singleThingSpeakhmm?.fieldTitle


        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
