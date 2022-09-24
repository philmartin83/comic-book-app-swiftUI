//
//  HomeViewModel.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import Combine

class HomeViewModel: ObservableObject, HTTPClient {
    
    @Published var characters: [Character] = []
    @Published var errorMessage = ""
    
    @MainActor
    func fetchCharacters() {
        Task {
            let result = await getAllCharacters()
            switch result {
            case .success(let model):
                self.characters = model.apiDataSource?.characters ?? []
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func resetError() {
        errorMessage = StringConstants.emptyString
    }
    
    private func getAllCharacters() async -> Result<CharacterRoot, RequestError> {
        return await sendRequest(endpoint: CharacterEndpoint.getAllCharacters, responseModel: CharacterRoot.self)
    }
}

