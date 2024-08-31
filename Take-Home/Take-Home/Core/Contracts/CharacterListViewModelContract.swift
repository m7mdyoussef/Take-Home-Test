//
//  CharacterListViewModelContract.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import Foundation

// Protocol defining the input methods for the ViewModel
protocol CharacterListViewModelInput {
    func loadCharacters(status: String)
    func navigateTo(to: DestinationScreens)
}

// Protocol defining the properties and closures for the ViewModel
protocol CharacterListViewModelOutput {
    var isLoading: Bool { get set }
    var characters: [Character] { get }
    var filterOptions: [CharacterStatus] { get }
    var currentPage: Int { get }
    var maxPages: Int { get }
    var updateView: (() -> Void)? { get set }
    var updateLoadingState: ((Bool) -> Void)? { get set }
    var showErrorAlert: ((String) -> Void)? { get set }
}

// Typealias for the combined ViewModel contract
typealias CharacterListViewModelContract = CharacterListViewModelInput & CharacterListViewModelOutput
