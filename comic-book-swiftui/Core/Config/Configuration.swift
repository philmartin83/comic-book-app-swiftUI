//
//  Configuration.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import Foundation

enum Configuration {

    // MARK: - Public API

    static var apiKey: String {
        string(for: "API_KEY")
    }
    
    static var apiKeyPrivate: String {
        string(for: "API_KEY_PRIVATE")
    }
    
    
    // MARK: - Helper Methods

    static private func string(for key: String) -> String {
        Bundle.main.infoDictionary?[key] as! String
    }

}
