//
//  CharacterViewControllerSnapshot.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 28/11/22.
//

import SnapshotTesting
import XCTest

@testable import StoneChallenge

class CharacterViewControllerSnapshot: XCTestCase {

    func test_character_viewController_snapshot_portrait() throws {

        isRecording = false

        let sut = CharacterViewController(
            viewModelProvider: CharacterPresenter(
                interactor: CharacterInteractor.mock(cache: ImageCacheStub()),
                router: CharacterRouter.mock(),
                character: Character(
                    id: 1,
                    name: "Rick Sanchez",
                    status: "Alive",
                    species: "Human",
                    type: "",
                    gender: "Male",
                    origin: Character.Location(
                        name: "Earth",
                        url: "https://rickandmortyapi.com/api/location/1"
                    ),
                    location: Character.Location(
                        name: "Earth",
                        url: "https://rickandmortyapi.com/api/location/20"
                    ),
                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    episode: [
                        "https://rickandmortyapi.com/api/episode/1",
                        "https://rickandmortyapi.com/api/episode/2"
                    ],
                    url: "https://rickandmortyapi.com/api/character/1",
                    created: "2017-11-04T18:48:46.250Z"
                )
            )
        )

        XCUIDevice.shared.orientation = .portrait

        // Assert
        assertSnapshots(matching: sut, as: [.image(on: .iPhoneXr(.portrait))])
    }

    func test_character_viewController_snapshot_landscape() throws {

        isRecording = false

        let sut = CharacterViewController(
            viewModelProvider: CharacterPresenter(
                interactor: CharacterInteractor.mock(cache: ImageCacheStub()),
                router: CharacterRouter.mock(),
                character: Character(
                    id: 1,
                    name: "Rick Sanchez",
                    status: "Alive",
                    species: "Human",
                    type: "",
                    gender: "Male",
                    origin: Character.Location(
                        name: "Earth",
                        url: "https://rickandmortyapi.com/api/location/1"
                    ),
                    location: Character.Location(
                        name: "Earth",
                        url: "https://rickandmortyapi.com/api/location/20"
                    ),
                    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                    episode: [
                        "https://rickandmortyapi.com/api/episode/1",
                        "https://rickandmortyapi.com/api/episode/2"
                    ],
                    url: "https://rickandmortyapi.com/api/character/1",
                    created: "2017-11-04T18:48:46.250Z"
                )
            )
        )

        XCUIDevice.shared.orientation = .landscapeRight

        // Assert
        assertSnapshots(matching: sut, as: [.image(on: .iPhoneXr(.landscape))])
    }
}
