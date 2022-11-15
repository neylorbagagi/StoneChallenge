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
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
}
