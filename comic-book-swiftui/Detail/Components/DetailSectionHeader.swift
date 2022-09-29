//
//  DetailSectionHeader.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import SwiftUI

struct DetailSectionHeader: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title3)
            .foregroundColor(.white)
            .padding()
            .background(.red)
            .shadow(color: .black, radius: 0, x: 1, y: 1)
    }
}

struct DetailSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        DetailSectionHeader(title: "Hello")
    }
}
