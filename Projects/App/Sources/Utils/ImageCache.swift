//
//  ImageCache.swift
//  babya
//
//  Created by dgsw8th61 on 11/14/24.
//

import SwiftUI

class ImageCache {
    static let shared = ImageCache()
    private var cache = NSCache<NSURL, UIImage>()
    
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    func save(image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

struct CachedAsyncImage<Content: View>: View {
    let url: URL
    let content: (Image) -> Content
    
    @State private var uiImage: UIImage? = nil
    
    var body: some View {
        if let uiImage = uiImage {
            content(Image(uiImage: uiImage))
        } else {
            ProgressView()
                .onAppear {
                    loadImage()
                }
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(for: url) {
            uiImage = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    ImageCache.shared.save(image: image, for: url)
                    DispatchQueue.main.async {
                        uiImage = image
                    }
                } else {
                    DispatchQueue.main.async {
                        uiImage = UIImage(named: "diary")
                    }
                }
            }.resume()
        }
    }
}
