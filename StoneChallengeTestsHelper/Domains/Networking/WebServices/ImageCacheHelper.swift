//
//  ImageCacheHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import Foundation
import UIKit
@testable import StoneChallenge

class ImageCacheStub: ImageCacheProtocol {

    var response: UIImage?

    var cachedImages = NSCache<NSURL, UIImage>()

    var placeholderImage: UIImage = UIImage(named: "image_not_found")!

    func image(url: NSURL) -> UIImage? {
        return response
    }

    func load(url: NSURL, completion: @escaping (UIImage?) -> Void) {
        completion(response)
    }
}
