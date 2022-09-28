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
    func fetchCharacters(pageNumber: Int) {
        Task {
            let result = await getAllCharacters(pageNumber: pageNumber)
            switch result {
            case .success(let model):
                self.characters.append(contentsOf: model.apiDataSource?.characters ?? [])
            case .failure(let error):
                self.errorMessage = error.customMessage
            }
        }
    }
    
    func resetError() {
        errorMessage = StringConstants.emptyString
    }
    
    func shouldFetchData(id: Int) -> Bool {
        return id == characters.count-2
    }
    
    private func getAllCharacters(pageNumber: Int) async -> Result<CharacterRoot, RequestError> {
        return await sendRequest(endpoint: HomeEndpoint.getAllCharacters(pageNumber: pageNumber), responseModel: CharacterRoot.self)
    }
}

