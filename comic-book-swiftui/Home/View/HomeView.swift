//
//  HomeView.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                Text("Comicbook App")
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                Spacer()
            }
            .padding()
            .background(.red)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(vm.characters, id: \.id) { character in
                        VStack {
                            AsyncImage(url: URL(string: character.thumbnail?.characterImage ?? "")!) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .overlay(ImageOverlay(name: character.name ?? ""), alignment: .bottomTrailing)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                        .frame(minHeight: 100)
                        .cornerRadius(8)
                        .padding()
                    }
                }
            }
        }
        .onAppear{
            vm.fetchCharacters()
        }
    }
    
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
