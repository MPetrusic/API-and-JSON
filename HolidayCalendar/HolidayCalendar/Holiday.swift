//
//  Holiday.swift
//  HolidayCalendar
//
//  Created by Milos Petrusic on 09/11/2020.
//

import Foundation

struct HolidayResponse: Codable {
    var response: Holidays
}

struct Holidays: Codable {
    var holidays: [HolidayDetail]
}

struct HolidayDetail: Codable {
    var name: String
    var date: DateInfo
}

struct DateInfo: Codable {
    var iso: String
}
