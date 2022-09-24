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
}

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}
