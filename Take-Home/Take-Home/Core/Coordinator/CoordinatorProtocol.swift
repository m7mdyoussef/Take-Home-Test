//
//  CoordinatorProtocol.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
    func navigateToNextScreen(destination: DestinationScreens)
    func dismiss()
    func navigateToRoot()
}

enum DestinationScreens{
    case Splash
    case CharactersList
    case Details(Character)
}

extension DestinationScreens: Equatable{
    static func == (lhs: DestinationScreens, rhs: DestinationScreens) -> Bool {
        switch (lhs, rhs) {
        case (.Splash, .Splash):
            return true
        case (.CharactersList, .CharactersList):
            return true
        case (.Details(let lhsCharacter), .Details(let rhsCharacter)):
            return lhsCharacter == rhsCharacter
        default:
            return false
        }
    }
}
