//
//  ImageOverlay.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 02/10/2022.
//

import SwiftUI

struct ImageOverlay: View {
    var name = ""
    var body: some View {
        ZStack {
            Text("\(name)")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }
        .background(.black)
        .opacity(0.8)
        .cornerRadius(8)
        .padding(6)
    }
}
