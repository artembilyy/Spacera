//
//  TextFormatter.swift
//  Spacera
//
//  Created by Artem Bilyi on 19.12.2022.
//

import Foundation
// MARK: - Format cases
enum DateFormat: String {
    case yyyyMMdd           = "yyyy-MM-dd"
    case MMddyyyy           = "MM/dd/yyyy"
    case yyyyMMddTHHmmssZ   = "yyyy-MM-dd'T'HH:mm:ssZ"
    case MMMMdyyyy          = "MMMM d, yyyy"
}
// MARK: - Convering formats
final class TextFormatter {
    static func convertDateFormat(date: String, from input: DateFormat, to output: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = input.rawValue
        guard let currentDate = formatter.date(from: date) else { return "" }
        formatter.dateFormat = output.rawValue
        let resultString = formatter.string(from: currentDate)
        return resultString
    }
    static func roundNumberWithUnit(_ number: String) -> String {
        let symbol = "$"
        let units = ["K", "M", "B", "T"]
        guard let num = Double(number) else { return "" }
        if (num < 1000.0) {
            return "\(symbol)\(String(describing: num))"
        }
        let exp: Int = Int(log10(num) / 3.0)
        let roundedNum: Double = round(10 * num / pow(1000.0, Double(exp))) / 10
        return "\(symbol)\(roundedNum) \(units[exp - 1])"
    }
    static func numberWithCommas(_ number: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let value = Int(number) else { return "" }
        return numberFormatter.string(from: NSNumber(value: value))!
    }
}
