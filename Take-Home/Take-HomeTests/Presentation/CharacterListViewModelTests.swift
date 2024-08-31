//
//  CharacterListViewModelTests.swift
//  TakeHomeTests
//
//  Created by JOE on 31/08/2024.
//

import XCTest
@testable import TakeHome

class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharacterListViewModel!
    var mockFetchCharactersUseCase: MockFetchCharactersUseCase!
    var mockCoordinator: MockCoordinator!

    override func setUp() {
        super.setUp()
        mockFetchCharactersUseCase = MockFetchCharactersUseCase()
        mockCoordinator = MockCoordinator()
        viewModel = CharacterListViewModel(coordinator: mockCoordinator, fetchCharactersUseCase: mockFetchCharactersUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockFetchCharactersUseCase = nil
        mockCoordinator = nil
        super.tearDown()
    }

    func testLoadCharactersSuccess() {
        let expectation = self.expectation(description: "Load characters")
        // Given
        let expectedCharacters = [MockData.character1]
        
        let mockResponse = CharactersResponse(results: expectedCharacters, info: Info(count: 100, pages: 5))
        mockFetchCharactersUseCase.mockResult = mockResponse
        mockFetchCharactersUseCase.shouldReturnError = false

        viewModel.updateView = {
            // Ensure the view model's properties match the expected values
            XCTAssertEqual(self.viewModel.currentPage, 2)
            XCTAssertEqual(self.viewModel.maxPages, 5)
            XCTAssertEqual(self.viewModel.characters.count, 1)
            XCTAssertEqual(self.viewModel.characters.first?.name, "Rick")
            XCTAssertEqual(self.viewModel.characters.first?.location?.name, "Earth")

            expectation.fulfill()
        }
        
        viewModel.loadCharacters(status: CharacterStatus.alive.rawValue)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testLoadCharactersFailure() {
        let expectation = self.expectation(description: "Load characters failure")
        
        // Given
        mockFetchCharactersUseCase.shouldReturnError = true

        var errorMessage: String?
        viewModel.showErrorAlert = { message in
            errorMessage = message
            XCTAssertFalse(self.viewModel.isLoading, "isLoading should be false after a failure")
            expectation.fulfill()
        }
        
        // When
        viewModel.loadCharacters(status: CharacterStatus.dead.rawValue)
        
        // Then
        waitForExpectations(timeout: 1.0, handler: nil)
        XCTAssertEqual(errorMessage, APIError.general.desc)
    }


    func testNavigateToDetails() {
        // Given
        let character = MockData.character1

        // When
        viewModel.navigateTo(to: .Details(character))

        // Then
        XCTAssertEqual(mockCoordinator.navigationDestination, .Details(character))
    }
}

