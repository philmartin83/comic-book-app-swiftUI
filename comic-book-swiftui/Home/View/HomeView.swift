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
    @State private var pagingFetch = false
    @State private var firstFetch = true
    
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
                
                if firstFetch {
                    Spacer()
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(2)
                    Spacer()
              
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(vm.characters, id: \.id) { character in
                                VStack {
                                    NavigationLink(destination: CharacterDetailView(character: character), label: {
                                        CharacterCardView(character: character)
                                            .overlay(ImageOverlay(name: character.name ?? ""), alignment: .bottomTrailing)
                                            .onAppear{
                                                guard let index = vm.characters.firstIndex(where: {$0.id == character.id}) else {return}
                                                if vm.shouldFetchData(id: index) {
                                                    vm.pagingFetch = true
                                                    pageNumber += 1
                                                    vm.fetchCharacters(pageNumber: pageNumber)
                                                }
                                                
                                            }
                                        
                                    })
                                }
                                .frame(minHeight: 100)
                                .cornerRadius(8)
                                .padding(.leading, 5)
                                .padding(.trailing, 5)
                                .onChange(of: vm.pagingFetch) { newValue in
                                    pagingFetch = newValue
                                }
                                if pagingFetch {
                                    ProgressView()
                                        .scaleEffect(1)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .onChange(of: vm.firstFetch, perform: { newValue in
            firstFetch = newValue
        })
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
