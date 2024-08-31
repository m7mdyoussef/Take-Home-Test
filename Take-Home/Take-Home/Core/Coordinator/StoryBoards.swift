//
//  StoryBoards.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import UIKit

enum StoryBoards: String {
    case characters = "CharacterListViewController"
   
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass : T.Type) ->T {
        let storyBoardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyBoardID) as! T
    }
}
