//
//  CharacterListViewModel.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import Foundation

class CharacterListViewModel: CharacterListViewModelContract  {
    var characters: [Character] = []
    private(set) var filterOptions: [CharacterStatus] = CharacterStatus.allCases
    var filterStatus: String?
    private let fetchCharactersUseCase: FetchCharactersUseCase
    var currentPage: Int = 1
    var maxPages: Int = 1
    private var pageCount: Int = 20
    var isLoading = false {
        didSet {
            updateLoadingState?(isLoading)
        }
    }
    var coordinator: CoordinatorProtocol
    var updateView: (() -> Void)?
    var updateLoadingState: ((Bool) -> Void)?
    var showErrorAlert: ((String) -> Void)?

    init(coordinator: CoordinatorProtocol, fetchCharactersUseCase: FetchCharactersUseCase) {
        self.coordinator = coordinator
        self.fetchCharactersUseCase = fetchCharactersUseCase
    }

    func loadCharacters(status: String = CharacterStatus.All.rawValue) {
        guard !isLoading, currentPage <= maxPages else { return }
        isLoading = true
        // Reset characters when switching filters
        if filterStatus != status {
            characters.removeAll()
            currentPage = 1
        }
        
        fetchCharactersUseCase.execute(page: "\(currentPage)", count: "\(pageCount)", status: status) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let result):
                    if let result = result {
                        self?.characters.append(contentsOf: result.results ?? [])
                        self?.currentPage += 1
                        self?.maxPages = result.info?.pages ?? 1
                        self?.filterStatus = status
                    }
                    self?.updateView?()
                case .failure(let error):
                    self?.showErrorAlert?(error.desc)
                }
            }
        }
    }

    func navigateTo(to: DestinationScreens) {
        switch to {
        case .Details(let character):
            coordinator.navigateToNextScreen(destination: .Details(character))
        default:
            break
        }
    }
}
