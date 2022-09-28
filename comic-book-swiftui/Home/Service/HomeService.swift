//
//  HomeService.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import Foundation

enum HomeEndpoint {
    case getAllCharacters(pageNumber: Int)
}

extension HomeEndpoint: Endpoint {
    
    var path: String {
        switch self {
        case .getAllCharacters(let number):
            return "/v1/public/characters" + buildQueryString(pageNumber: number, isCharacterList: true)
        }
    }

    var method: RequestMethod {
        switch self {
        case .getAllCharacters:
            return .get
        }
    }

    var header: [String: String]? {
        switch self {
        case .getAllCharacters:
            return nil
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .getAllCharacters:
            return nil
        }
    }
    
}
