//
//  GlobalExtensions.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import Foundation

// MARK: Date Extension
extension Date {
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    func formattedString(withFormat format: String = "MM/dd/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    func settingTime(hours: String) -> Date? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        if let time = timeFormatter.date(from: hours) {
            let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
            
            var mergedComponents = DateComponents()
            mergedComponents.year = dateComponents.year
            mergedComponents.month = dateComponents.month
            mergedComponents.day = dateComponents.day
            mergedComponents.hour = timeComponents.hour
            mergedComponents.minute = timeComponents.minute
            
            return calendar.date(from: mergedComponents)
        }
        return self as Date?
    }
    
}

// MARK: String Extension
extension String {
    var removingAccentsUppercased: String {
        let mutableString = NSMutableString(string: self) as CFMutableString
        CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
        return (mutableString as String).uppercased()
    }
    
    static func googleStaticMapURL(latitude: Double, longitude: Double, apiKey: String, size: String = "149x72", zoom: Int = 12) -> String {
        return "https://maps.googleapis.com/maps/api/staticmap?center=\(latitude),\(longitude)&markers=color:red%7Csize:tiny%7C\(latitude),\(longitude)&zoom=\(zoom)&size=\(size)&maptype=roadmap&key=\(apiKey)"
    }
    
    func parsedDate(withFormat format: String = "MM/dd/yyyy") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.date(from: self)
    }
    
    
    
}
