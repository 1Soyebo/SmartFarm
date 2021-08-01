//
//  Models.swift
//  OsagieProject
//
//  Created by Ibukunoluwa Soyebo on 01/08/2021.
//

import Foundation

enum FieldNameEnum:String{
    case field1 = "Temperature (K)"
    case field2 = "Humidity (g.m-3)"
    case field3 = "Soil Moisture (%)"
    case field4 = "Methane"
}

class ThingSpeakField {
    internal init(fieldTitle: FieldNameEnum, field_value_array: [ThingSpeakFieldValues] = []) {
        self.fieldTitle = fieldTitle
        self.field_value_array = field_value_array
    }
    
    var fieldTitle:FieldNameEnum
    var field_value_array:[ThingSpeakFieldValues] = []
}


struct ThingSpeakFieldValues{
    var value:Double
    var time:Date
}
