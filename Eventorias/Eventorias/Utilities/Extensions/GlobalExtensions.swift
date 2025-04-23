//
//  GlobalExtensions.swift
//  Eventorias
//
//  Created by Bruno Evrard on 27/03/2025.
//

import Foundation
import SwiftUI

// MARK: DynamicTypeSize Extensions
extension DynamicTypeSize {
    
    // TODO: Voir si utile ???
    var scaleFactor: CGFloat {
        if (self.isAccessibilitySize)   {
            switch self {
            case .xSmall:
                return 0.8
            case .small:
                return 0.9
            case .medium:
                return 1.0
            case .large:
                return 1.1
            case .xLarge:
                return 1.2
            case .xxLarge:
                return 1.3
            case .xxxLarge:
                return 1.4
            case .accessibility1:
                return 1.6
            case .accessibility2:
                return 1.8
            case .accessibility3:
                return 1.8 //2.0
            case .accessibility4:
                return 1.8 //2.2
            case .accessibility5:
                return 1.8 //2.4
            @unknown default:
                return 1.0
            }
        }
        else    {
            return 1.0
        }
    }
}

// MARK: Date Extension

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy"
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: self)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.locale = Locale(identifier: "en_US")
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


extension View {
    @ViewBuilder func whiteDatePickerText() -> some View {
        if UITraitCollection.current.userInterfaceStyle == .light {
            self.colorInvert().colorMultiply(.white)
        } else {
            self.colorMultiply(.white)
        }
    }
}

