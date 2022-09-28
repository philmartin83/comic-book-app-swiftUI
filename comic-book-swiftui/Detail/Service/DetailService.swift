//
//  ComicService.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import Foundation

enum DetailService {
    case getComicsForCharacter(id: Int)
}

extension DetailService: Endpoint {
    
    var path: String {
        switch self {
        case .getComicsForCharacter(let id):
            return "/v1/public/characters/\(id)/comics" + buildQueryString()
        }
    }
    
    var method: RequestMethod {
        switch self{
        case .getComicsForCharacter:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .getComicsForCharacter:
            return nil
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .getComicsForCharacter:
            return nil
        }
    }
    
    
}

