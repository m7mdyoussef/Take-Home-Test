//
//  String+Extension.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import SwiftUI

extension String {
    var image: Image {
        return Image(self)
    }

    var systemImage: Image {
        return Image(systemName: self)
    }
}
