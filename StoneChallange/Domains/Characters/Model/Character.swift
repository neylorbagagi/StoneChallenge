//
//  Character.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 14/11/22.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
