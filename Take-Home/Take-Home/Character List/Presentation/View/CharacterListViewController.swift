//
//  CharacterListViewController.swift
//  TakeHome
//
//  Created by JOE on 28/08/2024.
//

import UIKit
import SwiftUI

class CharacterListViewController: BaseViewController {
    // MARK: - Properties
    var viewModel: CharacterListViewModel!
    private var alertManager = AlertManager()
    // Track the selected filter
    private var selectedFilter: String?
    private var loaderHostingController: UIHostingController<LoaderView>?
    private var alertHostingController: UIHostingController<ErrorAlertView>?

    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var charactersTableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        configureNavigationBarTitle(Constants.NavigationBar.Character, fontSize: 28)
        setupLoader()
        setupAlert()
        bindViewModel()
        // Set default filter and load characters based on the default filter
        if let defaultFilter = viewModel.filterOptions.first?.rawValue {
            updateSelectedFilter(to: defaultFilter)
        }
    }
    
    private func bindViewModel() {
        viewModel.updateView = { [weak self] in
            self?.updateUI()
        }
        
        viewModel.updateLoadingState = { [weak self] isLoading in
            self?.toggleLoader(isLoading)
        }
        
        viewModel.showErrorAlert = { [weak self] message in
            self?.showAlert(message: message)
        }
    }

    private func toggleLoader(_ show: Bool) {
        loaderHostingController?.rootView = LoaderView(isLoading: show)
        loaderHostingController?.view.isHidden = !show
    }
    
    private func updateSelectedFilter(to filter: String) {
        selectedFilter = filter
        viewModel.loadCharacters(status: filter)
    }

    private func setupCollectionView() {
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self
        filterCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.ReusableCell.Cell)
    }

    private func setupTableView() {
        charactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.ReusableCell.Cell)
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        charactersTableView.rowHeight = 110
        charactersTableView.showsVerticalScrollIndicator = false

    }
    
    private func updateUI() {
        charactersTableView.reloadData()
        filterCollectionView.reloadData()
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension CharacterListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ReusableCell.Cell, for: indexPath)
        let filter = viewModel.filterOptions[indexPath.item]
        let isSelected = filter.rawValue == (selectedFilter ?? "")

        let filterCellView = FilterCellView(filterName: filter.rawValue, isSelected: isSelected)
        cell.contentConfiguration = UIHostingConfiguration {
            filterCellView
        }
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = viewModel.filterOptions[indexPath.item].rawValue
        // Check if the clicked filter is the same as the current selected filter
        if filter == selectedFilter {
            return
        }
        // Update the selected filter and fetch new characters
        updateSelectedFilter(to: filter)
        
    }
}

// MARK: - UITableView DataSource & Delegate
extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReusableCell.Cell, for: indexPath)
        let character = viewModel.characters[indexPath.row]

        // SwiftUI cell integration
        cell.contentConfiguration = UIHostingConfiguration {
            CharacterCellView(character: character)
        }
        cell.selectionStyle = .none
        cell.contentView.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.navigateTo(to: .Details(viewModel.characters[indexPath.row]))
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.loadCharacters(status: selectedFilter ?? CharacterStatus.All.rawValue)
        }
    }
    
}

// MARK: - Alert
extension CharacterListViewController{
    
    private func setupAlert() {
        let alertView = ErrorAlertView(alertManager: alertManager, onDismiss: hideAlert)
        alertHostingController = UIHostingController(rootView: alertView)
        if let alertView = alertHostingController?.view {
            alertView.backgroundColor = .clear
            view.addSubview(alertView)
            alertView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                alertView.topAnchor.constraint(equalTo: view.topAnchor),
                alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])

        }
        alertHostingController?.view.isHidden = !alertManager.isVisible
    }

    private func showAlert(message: String) {
        DispatchQueue.main.async {
            self.alertManager.message = message
            self.alertManager.isVisible = true
            self.alertHostingController?.view.isHidden = !self.alertManager.isVisible
        }
    }

    private func hideAlert() {
        DispatchQueue.main.async {
            self.alertManager.isVisible = false
            self.alertHostingController?.view.isHidden = !self.alertManager.isVisible
            self.viewModel.loadCharacters(status: self.selectedFilter ?? CharacterStatus.All.rawValue)
        }
    }
}

// MARK: - Loader
extension CharacterListViewController{

    private func setupLoader() {
        let loaderView = LoaderView(isLoading: false)
        loaderHostingController = UIHostingController(rootView: loaderView)
        if let loaderView = loaderHostingController?.view {
            loaderView.backgroundColor = .clear
            view.addSubview(loaderView)
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                loaderView.topAnchor.constraint(equalTo: view.topAnchor),
                loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
    }
}



