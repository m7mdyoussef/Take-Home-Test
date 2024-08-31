//
//  ViewController+Extension.swift
//  Take-Home
//
//  Created by JOE on 31/08/2024.
//

import UIKit

extension UIViewController {
    
    static func instantiateFromStoryBoard(appStoryBoard : StoryBoards) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
    class var storyboardID : String {
        return "\(self)"
    }

}
