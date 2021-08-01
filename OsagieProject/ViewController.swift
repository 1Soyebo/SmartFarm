//
//  ViewController.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 28/07/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var verticalProgressBackground: UIView!
    @IBOutlet weak var verticalProgressBar: UIView!
    @IBOutlet weak var btnIncreaseWater: UIButton!
    @IBOutlet weak var topProgressContraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnIncreaseWater.layer.cornerRadius = btnIncreaseWater.frame.height/2
        
    }

    @IBAction func waterButtonTapped(_ sender: Any) {
        if verticalProgressBackground.frame.height > verticalProgressBar.frame.height{
            topProgressContraint.constant -= 5
        }
    }
    

}

