//
//  AsyncImageView.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var imageLoader = ImageLoader()
    private let urlString: String?
    private let targetSize: CGSize

    init(urlString: String?, targetSize: CGSize) {
        self.urlString = urlString
        self.targetSize = targetSize
    }

    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else {
                Image.Character.placeholder
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
        }
        .onAppear {
            imageLoader.load(urlString: urlString, targetSize: targetSize)
        }
        .onDisappear {
            imageLoader.cancel()
        }
    }
}

