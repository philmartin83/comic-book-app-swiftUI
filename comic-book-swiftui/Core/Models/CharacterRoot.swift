//
//  CharacterRoot.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import Foundation

struct CharacterRoot: Codable {
    let responseCode: Int?
    let apiDataSource: CharacterDataSource?
    
    enum CodingKeys: String, CodingKey{
        case responseCode = "code"
        case apiDataSource = "data"
    }
}

struct CharacterDataSource : Codable {
    let limit: Int?
    let numberOfCharacter: Int?
    let characters: [Character]?
    
    enum CodingKeys: String, CodingKey{
        case numberOfCharacters = "count"
        case characters = "results"
        case limit
    }
//
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        numberOfCharacter = try values.decodeIfPresent(Int.self, forKey: .numberOfCharacters)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        characters = try values.decodeIfPresent([Character].self, forKey: .characters)
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encodeIfPresent(self.numberOfCharacter, forKey: .numberOfCharacters)
        try values.encodeIfPresent(self.characters, forKey: .characters)
        try values.encodeIfPresent(self.limit, forKey: .limit)
    }
    
}

struct Character: Codable {
    let id : Int?
    let name : String?
    let description : String?
    let modified : String?
    let thumbnail : Thumbnail?
    let resourceURI : String?
    let comics : CharacterComics?
}

struct CharacterComics : Codable {
    let collectionURI : String?
}

struct Thumbnail : Codable {
    let path : String?
    let fileExtension : String?

    enum CodingKeys: String, CodingKey {
        case path
        case fileExtension = "extension"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        fileExtension = try values.decodeIfPresent(String.self, forKey: .fileExtension)
    }

}

