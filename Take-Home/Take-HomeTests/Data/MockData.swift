//
//  MockData.swift
//  TakeHomeTests
//
//  Created by JOE on 31/08/2024.
//

import Foundation
@testable import TakeHome

enum MockData {
    static let character1 = Character(id: 1, name: "Rick", status: "Alive", species: "Human", gender: "Male", image: "", location: CharacterLocation(name: "Earth"))
    static let character2 = Character(id: 2, name: "Apadango", status: "Alive", species: "Alien", gender: "Female", image: "", location: CharacterLocation(name: "Apadango"))
    
    static let jsonData = """
    {
        "results": [{
            "id": 1,
            "name": "Rick",
            "status": "Alive",
            "species": "Human",
            "gender": "Male",
            "image": "",
            "location": { "name": "Earth" }
        }],
        "info": { "count": 1, "pages": 1 }
    }
    """.data(using: .utf8)
}
