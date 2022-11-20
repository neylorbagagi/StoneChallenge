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

        init() {
            self.count = 0
            self.pages = 0
            self.next = "https://rickandmortyapi.com/api/character" // TODO: parece meio errado esse valor estar aqui
            self.prev = nil
        }
    }
}
