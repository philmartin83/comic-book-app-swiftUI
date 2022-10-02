//
//  ComicBookCard.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicBookCard: View {
    
    var comic: Comic
    
    var body: some View {
        VStack {
            AnimatedImage(url: URL(string: comic.cover?.characterImage ?? "")!)
                .resizable() // Resizable like
                .indicator(.activity) // Activity Indicator
                .transition(.fade(duration: 0.5)) // Fade Transition with duration
                .scaledToFit()
                .padding()
            Text(comic.title ?? "")
                .fontWeight(.bold)
                .lineLimit(2)
        }
       
    }
}
