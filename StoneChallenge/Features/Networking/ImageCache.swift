//
//  ImageCache.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import UIKit
import Foundation

public protocol ImageCacheProtocol {
    var cachedImages: NSCache<NSURL, UIImage> { get }
    var placeholderImage: UIImage { get }

    func image(url: NSURL) -> UIImage?

    func load(url: NSURL, completion: @escaping (UIImage?) -> Void)
}

public class ImageCache: ImageCacheProtocol {

    // MARK: - PRIVATE PROPERTIES
    public let cachedImages = NSCache<NSURL, UIImage>()

    // MARK: - PUBLIC PROPERTIES
    public var placeholderImage = UIImage(named: "image_not_found")!

    /// Convenience function to check image cache
    /// - Parameter url: valid path for image data
    /// - Returns: returns cached image if it exists
    public func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }

    /// Will check cache for images and if not found execute a data task
    /// - Parameters:
    ///   - url: valid path for image data
    ///   - completion: returns a image if it exists
    final public func load(url: NSURL, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = image(url: url) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }

        URLSession.shared.dataTask(with: url as URL) { (data, _, error) in
            guard
                let responseData = data,
                let image = UIImage(data: responseData),
                error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            completion(image)
            self.cachedImages.setObject(image, forKey: url, cost: responseData.count)
        }.resume()
    }

    public init() {}
}
