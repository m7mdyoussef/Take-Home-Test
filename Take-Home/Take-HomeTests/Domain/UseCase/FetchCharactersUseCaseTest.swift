//
//  FetchCharactersUseCaseTest.swift
//  TakeHomeTests
//
//  Created by JOE on 31/08/2024.
//

import XCTest
@testable import TakeHome

class FetchCharactersUseCaseTests: XCTestCase {

    var sut: FetchCharactersUseCase!
    var mockRepository: MockCharacterRepository!

    override func setUp() {
        super.setUp()
        mockRepository = MockCharacterRepository()
        sut = FetchCharactersUseCaseImpl(repository: mockRepository)
    }

    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }

    func testFetchCharacters_Success() {
        // Given
        mockRepository.characters = [
            MockData.character1,
            MockData.character2
        ]

        let expectation = self.expectation(description: "Fetch Characters Success")

        // When
        sut.execute(page: "1", count: "20", status: "Alive") { result in
            // Then
            switch result {
            case .success(let response):
                XCTAssertEqual(response?.results?.count, 2)
                XCTAssertEqual(response?.results?.first?.name, "Rick")
                XCTAssertEqual(response?.results?.first?.gender, "Male")
                XCTAssertEqual(response?.results?.first?.species, "Human")
                XCTAssertEqual(response?.results?.first?.location?.name, "Earth")
                XCTAssertEqual(response?.results?[1].name, "Apadango")
                XCTAssertEqual(response?.results?[1].gender, "Female")
                XCTAssertEqual(response?.results?[1].species, "Alien")
                XCTAssertEqual(response?.results?[1].location?.name, "Apadango")

                expectation.fulfill()

            case .failure:
                XCTFail("Expected success but got failure.")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCharacters_Failure() {
        // Given
        mockRepository.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch Characters Failure")

        // When
        sut.execute(page: "1", count: "20", status: "Alive") { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, .noData)
                XCTAssertEqual(error.desc, MessageHelper.ServerError.notFound)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}


