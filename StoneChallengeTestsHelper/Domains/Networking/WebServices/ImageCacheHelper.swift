//
//  ImageCacheHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 25/11/22.
//

import Foundation
import UIKit
@testable import StoneChallenge

// TODO: Make TestsHelper as target to evoid make it public
public class ImageCacheStub: ImageCacheProtocol {

    var response: UIImage?

    public var cachedImages = NSCache<NSURL, UIImage>()

    public var placeholderImage: UIImage = UIImage(named: "image_not_found")!

    public func image(url: NSURL) -> UIImage? {
        return response
    }

    public func load(url: NSURL, completion: @escaping (UIImage?) -> Void) {
        completion(response)
    }

    public init() {}
}
