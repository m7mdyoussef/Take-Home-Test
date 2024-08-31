//
//  Color+Extension.swift
//  TakeHome
//
//  Created by JOE on 31/08/2024.
//

import SwiftUI

extension Color{

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        let red, green, blue: Double
        switch hex.count {
        case 6:
            red = Double((rgb >> 16) & 0xFF) / 255.0
            green = Double((rgb >> 8) & 0xFF) / 255.0
            blue = Double(rgb & 0xFF) / 255.0
        default:
            red = 0.0
            green = 0.0
            blue = 0.0
        }

        self.init(
            .sRGB,
            red: red,
            green: green,
            blue: blue,
            opacity: 1.0
        )
    }
    
    // Define your custom colors
    static let statusColor = Color(hex: "#61CBF4")
    static let heavyTextColor = Color(hex: "#170341")
    static let lightTextColor = Color(hex: "#827C9C")
    static let mediumTextColor = Color(hex: "#504974")
    static let deadColor = Color(hex: "#FBE7EB")
    static let aliveColor = Color(hex: "#EBF6FB")

}
