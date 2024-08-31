//
//  CharactersResponse.swift
//  Take-Home
//
//  Created by JOE on 30/08/2024.
//

import Foundation

struct CharactersResponse: Codable {
    let results: [Character]?
    let info:Info?
}

struct Info: Codable {
    let count: Int?
    let pages:Int?
}

struct Character: Codable, Identifiable, Equatable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
    let location:CharacterLocation?
}


struct CharacterLocation: Codable, Equatable {
    let name: String?
}

enum CharacterStatus: String, CaseIterable {
    case All
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
