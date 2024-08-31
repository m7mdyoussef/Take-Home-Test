//
//  MockCoordinator.swift
//  TakeHomeTests
//
//  Created by JOE on 31/08/2024.
//

import UIKit
@testable import TakeHome

// Mock Coordinator
class MockCoordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    var navigationDestination: DestinationScreens?

    func navigateToNextScreen(destination: DestinationScreens) {
        navigationDestination = destination
    }
    
    func start(){}
    func dismiss(){}
    func navigateToRoot(){}
}
