//
//  CharactersViewControllerSnapshot.swift
//  StoneChallengeTests
//
//  Created by Neylor Bagagi on 28/11/22.
//

import SnapshotTesting
import XCTest

@testable import StoneChallenge

class CharactersViewControllerSnapshot: XCTestCase {

    func test_characters_viewController_snapshot() throws {

        isRecording = false

        let sut = CharactersViewController(
            viewModelProvider: CharactersPresenter(
                interactor: CharactersInteractor.mock(
                    cache: ImageCacheStub()
                ),
                router: CharactersRouter.mock(),
                characterList: [Character](
                    repeating: Character(
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
                    ),
                    count: 20
                )
            )
        )

        assertSnapshots(matching: sut, as: [.image()])
    }
}
