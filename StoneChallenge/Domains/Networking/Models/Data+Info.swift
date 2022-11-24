//
//  Data+Info.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 15/11/22.
//

import Foundation

// MARK: - DataInfo
public struct DataInfo<T: Codable>: Codable {
    let info: Info
    let results: [T]
}
