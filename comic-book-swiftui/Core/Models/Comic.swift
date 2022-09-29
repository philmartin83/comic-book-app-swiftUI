//
//  Comic.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import Foundation

struct ComicRoot: Codable {
    
    let responseCode: Int?
    let apiDataSource: ComicBookDataSource?
    
    enum CodingKeys: String, CodingKey{
        case responseCode = "code"
        case apiDataSource = "data"
    }
}


struct ComicBookDataSource : Codable {
    let comics: [Comic]?
    
    enum CodingKeys: String, CodingKey{
        case comics = "results"
    }
}

struct Comic: Codable {
    let id: Int?
    let title: String?
    let description: String?
    let issueNumber: Int?
    let pageCount: Int?
    let cover: Thumbnail?
    let fallbackCover: [Thumbnail]?
    
    enum CodingKeys: String, CodingKey{
        case cover = "thumbnail", fallbackCover = "images", id
        case issueNumber, pageCount, title, description
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cover = try values.decodeIfPresent(Thumbnail.self, forKey: .cover)
        fallbackCover = try values.decodeIfPresent([Thumbnail].self, forKey: .fallbackCover)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        issueNumber = try values.decodeIfPresent(Int.self, forKey: .issueNumber)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }    
}
