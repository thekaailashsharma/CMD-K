//
//  ImageViewModel.swift
//  ChatApp
//
//  Created by Admin on 10/02/24.
//

import SwiftUI

class ImageViewModel: ObservableObject {
    @Published var image: NSImage?

    private var imageCache: NSCache<NSString, NSImage>?

    init(urlString: String?) {
        loadImage(urlString: urlString)
    }

    private func loadImage(urlString: String?) {
        guard let urlString = urlString else { return }

        if let imageFromCache = getImageFromCache(from: urlString) {
            self.image = imageFromCache
            return
        }

        loadImageFromURL(urlString: urlString)
    }

    private func loadImageFromURL(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error ?? "unknown error")
                return
            }

            guard let data = data else {
                print("No data found")
                return
            }

            DispatchQueue.main.async { [weak self] in
                guard let loadedImage = NSImage(data: data) else { return }
                self?.image = loadedImage
                self?.setImageCache(image: loadedImage, key: urlString)
            }
        }.resume()
    }

    private func setImageCache(image: NSImage, key: String) {
        imageCache?.setObject(image, forKey: key as NSString)
    }

    private func getImageFromCache(from key: String) -> NSImage? {
        return imageCache?.object(forKey: key as NSString) as? NSImage
    }
}
