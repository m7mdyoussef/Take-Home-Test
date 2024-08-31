//
//  UIImage+Extension.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import UIKit
import SwiftUI

extension UIImage {
    static var emptyImage: UIImage {
        return UIImage()
    }
    
    static var backButton: UIImage {
        return UIImage(systemName: "arrow.left") ?? .emptyImage
    }
}

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}

extension Image {
    enum Character {
        static let imagePlaceholder = "imagePlaceHolder".image
        static let placeholder = "placeHolder".image
    }
}
