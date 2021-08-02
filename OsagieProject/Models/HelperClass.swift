//
//  HelperClass.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 02/08/2021.
//

import Foundation
import Charts

public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    private let objects:[ThingSpeakFieldValues]
    
    init(objects: [ThingSpeakFieldValues]) {
        self.objects = objects
        super.init()
        dateFormatter.dateFormat = "HH:mm"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if value >= 0 && value < Double(objects.count){
            let object = objects[Int(value)]
            return dateFormatter.string(from: object.actualTime)
        }
        return ""
    }
}
