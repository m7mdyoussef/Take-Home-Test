//
//  AppCoordinator.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import UIKit
import SwiftUI


class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {

    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.navigationController.isNavigationBarHidden = false
            self.navigationController.popViewController(animated: true)
        }
    }
    
    func navigateToRoot() {
        DispatchQueue.main.async {
            self.navigationController.popToRootViewController(animated: true)
            self.navigationController.dismiss(animated: true)
        }
    }
    
    func navigateToNextScreen(destination: DestinationScreens){
        switch destination{
        case .Splash:
            start()
        case .CharactersList:
            openCharacterListScreen()
        case .Details(let character):
            openCharacterDetailsScreen(character: character)
        }
        
    }
    
    private func openCharacterListScreen() {

    }
    
    private func openCharacterDetailsScreen(character: Character) {

    }
}
