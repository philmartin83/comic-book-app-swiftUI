//
//  HomeView.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 24/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    @State private var pageNumber: Int = 0
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Comicbook App")
                        .font(.title2)
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
                                NavigationLink(destination: CharacterDetailView(character: character), label: {
                                    WebImage(url: URL(string: character.thumbnail?.characterImage ?? "")!)
                                        .resizable() // Resizable like
                                        .indicator(.activity) // Activity Indicator
                                        .transition(.fade(duration: 0.5)) // Fade Transition with duration
                                        .scaledToFit()
                                        .overlay(ImageOverlay(name: character.name ?? ""), alignment: .bottomTrailing)
                                        .onAppear{
                                            guard let index = vm.characters.firstIndex(where: {$0.id == character.id}) else {return}
                                            if vm.shouldFetchData(id: index) {
                                                pageNumber += 1
                                                vm.fetchCharacters(pageNumber: pageNumber)
                                            }
                                           
                                        }
                                })
                            }
                            .frame(minHeight: 100)
                            .cornerRadius(8)
                            .padding([.leading, .trailing])
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear{
            vm.fetchCharacters(pageNumber: pageNumber)
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
