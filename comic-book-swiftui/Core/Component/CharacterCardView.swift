//
//  CharacterCardView.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterCardView: View {
    
    var character: Character
    
    var body: some View {
        AnimatedImage(url: URL(string: character.thumbnail?.characterImage ?? "")!)
            .resizable() // Resizable like
            .indicator(.activity) // Activity Indicator
            .transition(.fade(duration: 0.5)) // Fade Transition with duration
            .scaledToFit()
    }
}

struct CharacterCardView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterCardView(character: Character(id: 0, name: "", description: "", modified: "", thumbnail: nil, resourceURI: "", comics: nil))
    }
}
