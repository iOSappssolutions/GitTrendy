//
//  Formatter.swift
//  GitTrendyModel
//
//  Created by Miroslav Djukic on 19/09/2020.
//

import Foundation

let queryDateFromatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "YYYY-MM-dd"
    formatter.timeZone = TimeZone.current
    return formatter
}()
