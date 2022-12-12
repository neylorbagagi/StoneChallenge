//
//  APIParameter.swift
//  StoneChallange
//
//  Created by Neylor Bagagi on 19/11/22.
//

import Foundation

public enum APIParameter: CaseIterable {

    public static var allCases: [APIParameter] {
        return [
            .name(nil),
            .status(nil),
            .species(nil),
            .type(nil),
            .gender(nil)
        ]
    }

    case name(String?)
    case status(APIParameter.Status?)
    case species(String?)
    case type(String?)
    case gender(APIParameter.Gender?)

    func describe() -> String {
        switch self {
        case .name:
            return "name"
        case .status:
            return "status"
        case .species:
            return "species"
        case .type:
            return "type"
        case .gender:
            return "gender"
        }
    }

    func getValue() -> String? {
        switch self {
        case .name(let string):
            return string
        case .status(let status):
            return status?.rawValue
        case .species(let string):
            return string
        case .type(let string):
            return string
        case .gender(let gender):
            return gender?.rawValue
        }
    }

    static func withLabel(_ label: String) -> APIParameter? {
        return self.allCases.first { "\(String(describing: $0.getValue()))" == label }
    }
}
