//
//  HomeService.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import Foundation

enum CharacterEndpoint {
    case getAllCharacters
}

extension CharacterEndpoint: Endpoint {
    
    private var limit: Int {
        30
    }
    
    var path: String {
        switch self {
        case.getAllCharacters:
            return "/v1/public/characters" + buildQueryString(pageNumber: 0, isCharacterList: true)
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
    
    // MARK: - Helpers
    private func buildQueryString(pageNumber: Int = 0, isCharacterList: Bool = false) -> String{
        let timeStamp = Date().timeIntervalSince1970
        var queryString = "?ts=\(timeStamp)&apikey=\(Configuration.apiKey)&hash=\(buildHashToken(timestamp: timeStamp))"
        if isCharacterList{
            var pageNumber = pageNumber
            pageNumber = limit * pageNumber
            queryString = queryString + "&limit=\(limit)&offset=\(pageNumber)"
        }
        return queryString
    }

    private func buildHashToken(timestamp: TimeInterval) -> String{
        let unhashedString = "\(timestamp)" + Configuration.apiKeyPrivate + Configuration.apiKey
        return Hash.MD5(string: unhashedString)
    }
}
