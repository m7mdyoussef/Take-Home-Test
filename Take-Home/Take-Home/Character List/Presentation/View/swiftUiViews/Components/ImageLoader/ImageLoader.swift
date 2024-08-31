//
//  ImageLoader.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func load(urlString: String?, targetSize: CGSize) {
        guard let urlString = urlString, !urlString.isEmpty, let url = URL(string: urlString) else {
            self.image = UIImage(named: "placeHolder")
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { data in
                UIImage(data: data)?.resized(to: targetSize)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] resizedImage in
                self?.image = resizedImage
            })
    }

    func cancel() {
        cancellable?.cancel()
    }
}

