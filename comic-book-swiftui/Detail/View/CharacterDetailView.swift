//
//  CharacterDetailView.swift
//  comic-book-swiftui
//
//  Created by Phil Martin on 28/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CharacterDetailView: View {
    
    @Environment(\.presentationMode) var presentation
    
    var character: Character
    @StateObject private var vm = DetailViewModel()
    private let noBio = StringConstants.noBio
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presentation.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 25))
                        .shadow(color: .black, radius: 0, x: 1, y: 1)
                    Text(StringConstants.characterDetailTitle)
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.leading, 10)
                        .shadow(color: .black, radius: 0, x: 1, y: 1)
                    Spacer()
                }
                
                Spacer()
            }
            .padding()
            .background(.red)
            ScrollView {
                VStack {
                    HStack {
                        CharacterCardView(character: character)
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
                            .shadow(color: .gray.opacity(0.7), radius: 0, x: 2, y: 2)
                            .padding(.leading, 16)
                            .padding(.top, 16)
                        Text(character.name ?? "")
                            .foregroundColor(.primary)
                            .font(.title3)
                            .padding(.leading, 20)
                        Spacer()
                        
                    }
                    DetailSectionHeader(title: StringConstants.characterBioSectionHeaderTitle)
                    
                    Text(character.description?.isEmpty == true ? noBio : character.description ?? noBio )
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.primary)
                        .padding()
                    
                    DetailSectionHeader(title: StringConstants.characterComicsSectionHeaderTitle)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(vm.comics, id: \.id) { comic in
                                ComicBookCard(comic: comic)
                                    .frame(idealWidth: 150, maxWidth: 150, maxHeight: .infinity)
                            }
                        }
                    }.scrollIndicators(.hidden)
                    
                }
            }.navigationBarHidden(true)
            .onAppear{
                vm.getComicsForCharacter(id: character.id)
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: Character(id: 0, name: "", description: "", modified: "", thumbnail: nil, resourceURI: "", comics: nil))
    }
}
