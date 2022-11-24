//
//  CharacterHelper.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 23/11/22.
//

import Foundation
@testable import StoneChallenge

extension Character: Equatable {

    public static func mock(
        id: Int = .init(),
        name: String = .init(),
        status: String = .init(),
        species: String = .init(),
        type: String = .init(),
        gender: String = .init(),
        origin: Character.Location = .mock(),
        location: Character.Location = .mock(),
        image: String = .init(),
        episode: [String] = .init(),
        url: String = .init(),
        created: String = .init()
    ) -> Character {
        .init(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            url: url,
            created: created
        )
    }

    public static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.status == rhs.status &&
        lhs.species == rhs.species &&
        lhs.type == rhs.type &&
        lhs.gender == rhs.gender &&
        lhs.origin == rhs.origin &&
        lhs.location == rhs.location &&
        lhs.image == rhs.image &&
        lhs.episode == rhs.episode &&
        lhs.url == rhs.url &&
        lhs.created == rhs.created
    }
}
