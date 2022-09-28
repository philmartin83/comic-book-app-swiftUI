//
//  DetailViewModel.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import Foundation


class DetailViewModel: ObservableObject, HTTPClient {
    
    @Published var comics: [Comic] = []
    @Published var errorMessage = ""
    
    // MARK: - Helpers
    @MainActor
    func getComicsForCharacter(id: Int) {
        Task {
            let result = await getComicsForCharacter(id: id)
            switch result {
            case .success(let root):
                self.comics = root.apiDataSource?.comics ?? []
            case .failure(let error):
                self.errorMessage = error.customMessage
            }
        }
    }
    
    private func getComicsForCharacter(id: Int) async -> Result<ComicRoot, RequestError> {
        return await sendRequest(endpoint: DetailService.getComicsForCharacter(id: id), responseModel: ComicRoot.self)
    }
    
}
