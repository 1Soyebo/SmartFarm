//
//  HomeViewController.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 01/08/2021.
//

import UIKit
import DateToolsSwift
import PKHUD

class HomeViewController: UIViewController {
    
    let hmmEndpoint = "https://api.thingspeak.com/channels/1419598/feeds.json?api_key=SWN0URWO02UU9SAS"
    var arrayResponseFromJSON:[ThingSpeakField] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Smart Farm"
        callApiFromThingSpeak{
            
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func temperatureTapped(_ sender: Any) {
        let newDetailVc = NewDetailViewController(nibName: "NewDetailViewController", bundle: nil)

        newDetailVc.singleThingSpeakhmm = arrayResponseFromJSON[0]
        navigationController?.pushViewController(newDetailVc, animated: true)
    }
    
    @IBAction func humidityTapper(_ sender: Any) {
        let newDetailVc = NewDetailViewController(nibName: "NewDetailViewController", bundle: nil)

        newDetailVc.singleThingSpeakhmm = arrayResponseFromJSON[1]
        navigationController?.pushViewController(newDetailVc, animated: true)
    }
    
    @IBAction func methaneTapped(_ sender: Any) {
        let newDetailVc = NewDetailViewController(nibName: "NewDetailViewController", bundle: nil)

        newDetailVc.singleThingSpeakhmm = arrayResponseFromJSON[2]
        navigationController?.pushViewController(newDetailVc, animated: true)
    }
    
    @IBAction func soilMoistureTapped(_ sender: Any) {
        let newDetailVc = NewDetailViewController(nibName: "NewDetailViewController", bundle: nil)

        newDetailVc.singleThingSpeakhmm = arrayResponseFromJSON[3]
        navigationController?.pushViewController(newDetailVc, animated: true)
    }
    
    
    fileprivate func callApiFromThingSpeak(completionHandler: @escaping () -> ()){
        HUD.show(.progress)
        ApiUtil.getRequest(viewController: self, endpoint: hmmEndpoint, customError: false, jsonHandler: { [self]
            response in
            let totalResponse = response.value as? [String:Any]
//            print(response.value)
            let channel = totalResponse?["channel"] as? [String:Any]
            let feeds = totalResponse?["feeds"] as? NSArray

//            print(channel)
//            print(feeds)
            for n in 1...4{
                var singleThingSpeakField = ThingSpeakField()
                let fieldTitle = channel?["field\(n)"] as? String
//                print(fieldTitle)
                singleThingSpeakField.fieldTitle = fieldTitle ?? ""
                if fieldTitle != nil {
                    arrayResponseFromJSON.append(singleThingSpeakField)
                    if let feeds = feeds{
                        for oneFeed in feeds{
                            let oneFeedDict = oneFeed as? [String:Any]
                            let createdAtTime = oneFeedDict?["created_at"] as? String ?? ""
        
//                            print(createdAtTime)
                            let createdDateFormatter = DateFormatter()
                            createdDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                            
                            let actualDate = createdDateFormatter.date(from: createdAtTime ?? "")
                            
//                            //create datestamp formatter
//                            let dateStampFormatter = DateFormatter()
//                            dateStampFormatter.dateFormat = "yyyy-MM-dd"
//
                            //create timestmap formatter
                            let timeStampFormatter = DateFormatter()
                            timeStampFormatter.dateFormat = "HH:mm:ss"
//
//
//                            let range = createdAtTime.index(createdAtTime.startIndex, offsetBy: 8)..<createdAtTime.index(createdAtTime.startIndex, offsetBy: 15)
//                            let k = createdAtTime.replacingCharacters(in: range, with: "")
                            
                            guard let hmmDate = actualDate else{
                                return
                            }
                            let componentsTime = Calendar.current.dateComponents([.hour, .minute, .second], from: hmmDate)
                            let hour = componentsTime.hour ?? 0
                            let minute = componentsTime.minute ?? 0
                            let second = componentsTime.second ?? 0
                            
                            let timeString = "\(hour):\(minute):\(second)"
                            
                            let actualTime = timeStampFormatter.date(from: timeString)
                            print(timeString)
                            
//                            print(actualDate?.d)
                            var singleThingSpeakFieldValue = ThingSpeakFieldValues()
                            
                            let singlefield = oneFeedDict?["field\(n)"] as? String
//                            print(singlefield)
                            singleThingSpeakFieldValue.wholeDate = actualDate ?? Date()
                            if let singlefield = singlefield, let actualTime = actualTime {
                                singleThingSpeakFieldValue.actualTime = actualTime
                                singleThingSpeakFieldValue.value = Int(singlefield) ?? 0
                                singleThingSpeakField.field_value_array.append(singleThingSpeakFieldValue)
                            }
                            
                        }
                    }

                }
//                print(arrayResponseFromJSON[n - 1].field_value_array.count)
            }
            HUD.hide()
            
                        

            
        }, onFailure: {})
    }
    
    fileprivate func fieldLoop(dict:[String:Any]){
        for n in 1...4{
            let hmm = dict["field\(n)"] as? Double
            if let hmm = hmm {
                
            }
        }
    }

}
