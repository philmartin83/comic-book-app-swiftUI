//
//  Thumbnail.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import Foundation

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
    
    var characterImage: String {
        "\(path ?? "").\(fileExtension ?? "")"
    }

}
