//
//  Endpoint.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://gateway.marvel.com"
    }
    
    private var limit: Int {
        return 30
    }
    
    func buildQueryString(pageNumber: Int = 0, isCharacterList: Bool = false) -> String{
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

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
