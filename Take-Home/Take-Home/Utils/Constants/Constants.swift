//
//  Constants.swift
//  Take-Home
//
//  Created by JOE on 30/08/2024.
//

import Foundation

enum Constants{

    enum APIConstatnts {
        static let baseURL = "https://rickandmortyapi.com/api"
        static let characterUrlPath = "/character"
        static let page = "page"
        static let count = "count"
        static let status = "status"
    }
    
    enum ProgressComponents {
        static let loading = "loading..."
    }
    
    enum NavigationBar {
        static let Character = "Character"
    }
    
    enum ReusableCell {
        static let Cell = "cell"
    }
    
    enum Alert {
        static let error = "Error"
        static let retry = "Retry"
    }
    
    enum CharacterDetails {
        static let location = "Location :  "
    }
    
}

