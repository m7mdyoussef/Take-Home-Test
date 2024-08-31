//
//  Injector.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import UIKit

class Injector {
    
    static func CharacterListViewController(coordinator: CoordinatorProtocol) -> CharacterListViewController {
        let repo = CharacterRepositoryImpl()
        let usecase = FetchCharactersUseCaseImpl(repository: repo)
        let viewModel = CharacterListViewModel(coordinator: coordinator, fetchCharactersUseCase: usecase)
        let viewcontroller = Take_Home.CharacterListViewController.instantiateFromStoryBoard(appStoryBoard: .characters)
        viewcontroller.viewModel = viewModel
        return viewcontroller
    }
    
    static func getCharacterDetailsView(coordinator: CoordinatorProtocol, character: Character) -> CharacterDetailView {
        return CharacterDetailView(character: character, coordinator: coordinator)
    }
}
