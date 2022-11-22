//
//  Info.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation

extension DataInfo {

    // MARK: - Info
    struct Info: Codable {
        var count: Int
        var pages: Int
        var next: String?
        let prev: String?

        init(count: Int = 0, pages: Int = 0, next: String? = nil, prev: String? = nil) {
            self.count = count
            self.pages = pages
            self.next = next
            self.prev = prev
        }
    }
}
