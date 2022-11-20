//
//  Status.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 20/11/22.
//

import Foundation

extension APIParameters {

    public enum Status: String, CaseIterable {
        case alive
        case dead
        case unknown
    }
}
