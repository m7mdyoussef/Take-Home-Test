//
//  CharacterRepositoryTest.swift
//  TakeHomeTests
//
//  Created by JOE on 31/08/2024.
//

import XCTest
@testable import TakeHome

class CharacterRepositoryTest: XCTestCase {

    var sut: CharacterRepositoryImpl! // System Under Test
    var mockAPIClient: MockCharacterAPIClient!

    override func setUp() {
        super.setUp()
        mockAPIClient = MockCharacterAPIClient()
        sut = CharacterRepositoryImpl(apiClient: mockAPIClient)
    }

    override func tearDown() {
        sut = nil
        mockAPIClient = nil
        super.tearDown()
    }

    func testFetchCharacters_Success() {
        // Given
        let jsonData = MockData.jsonData
        mockAPIClient.mockData = jsonData

        let expectation = self.expectation(description: "Fetch Characters Success")

        // When
        sut.fetchCharacters(page: "1", count: "20", status: "Alive") { result in
            // Then
            switch result {
            case .success(let response):
                XCTAssertEqual(response?.results?.count, 1, "Expected one character to be fetched.")
                XCTAssertEqual(response?.results?.first?.name, "Rick", "Expected character name to be 'Rick'.")
                expectation.fulfill()

            case .failure:
                XCTFail("Expected success but got failure.")
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCharacters_Failure_NoData() {
        // Given
        mockAPIClient.shouldReturnError = true
        mockAPIClient.errorType = .noData
        let expectation = self.expectation(description: "Fetch Characters Failure No Data")

        // When
        sut.fetchCharacters(page: "1", count: "20", status: "Alive") { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, .noData, "Expected noData error.")
                XCTAssertEqual(error.desc, MessageHelper.ServerError.notFound, "Expected 'not found' message.")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchCharacters_Failure_DecodingError() {
        // Given
        let invalidData = "invalid data".data(using: .utf8)
        mockAPIClient.mockData = invalidData

        let expectation = self.expectation(description: "Fetch Characters Failure Decoding Error")

        // When
        sut.fetchCharacters(page: "1", count: "20", status: "Alive") { result in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, .decodingError, "Expected decoding error.")
                XCTAssertEqual(error.desc, MessageHelper.ServerError.decodingError, "Expected decoding error message.")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchData_Failure_Timeout() {
        // Given
        mockAPIClient.shouldReturnError = true
        mockAPIClient.errorType = .timeout
        let expectation = self.expectation(description: "Fetch Data Failure Timeout")

        // When
        mockAPIClient.fetchData(target: ApplicationNetworking.fetchCharacters(page: "1", count: "20", status: "Alive")) { (result: Result<CharactersResponse?, APIError>) in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, .timeout, "Expected timeout error.")
                XCTAssertEqual(error.desc, MessageHelper.ServerError.timeOut, "Expected 'timeout' message.")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchData_Failure_NoNetwork() {
        // Given
        mockAPIClient.shouldReturnError = true
        mockAPIClient.errorType = .noNetwork
        let expectation = self.expectation(description: "Fetch Data Failure Timeout")

        // When
        mockAPIClient.fetchData(target: ApplicationNetworking.fetchCharacters(page: "1", count: "20", status: "Alive")) { (result: Result<CharactersResponse?, APIError>) in
            // Then
            switch result {
            case .success:
                XCTFail("Expected failure but got success.")
            case .failure(let error):
                XCTAssertEqual(error, .noNetwork, "Expected No Internet error.")
                XCTAssertEqual(error.desc, MessageHelper.ServerError.noInternet, "Expected 'noNetwork' message.")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 1.0)
    }
}


