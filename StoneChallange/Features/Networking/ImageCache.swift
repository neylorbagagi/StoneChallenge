//
//  ImageCache.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 18/11/22.
//

import UIKit
import Foundation
public class ImageCache {

//    public static let publicCache = ImageCache()
    var placeholderImage = UIImage(named: "image_not_found")!
    private let cachedImages = NSCache<NSURL, UIImage>()

    public final func image(url: NSURL) -> UIImage? {
        return cachedImages.object(forKey: url)
    }

    // TODO: da pra melhorrar isso ?
    final func load(url: NSURL, completion: @escaping (UIImage?) -> Void) {
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
}
