//
//  CharacterView.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 09/07/2025.
//

import SwiftUI

struct CharacterView: View {
    let character: CharacterModel
    let show: String
    
    var body: some View {
        GeometryReader {
            geo in
            ZStack(alignment: .top) {
                Image(show.lowercased().replacingOccurrences(of: " ", with: ""))
                    .resizable()
                    .scaledToFit()
                ScrollViewReader { proxy in
                    ScrollView (showsIndicators: false) {
                        TabView{
                            ForEach(character.images, id: \.self) { url in
                                AsyncImage(url: URL(string: url)){
                                    image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .clipShape(.rect(cornerRadius: 20))
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }.tabViewStyle(.page)
                            .frame(width:geo.size.width * 0.8,height: geo.size.height * 0.6)
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.top, 90)
                        
                        VStack (alignment: .leading){
                            Text(character.name)
                                .font(.title)
                            Text("Portrayed By : "+character.portrayedBy)
                                .font(.subheadline)
                            Text("Born : \(character.birthday)")
                            Divider()
                            ForEach(character.occupations, id: \.self) { occupation in
                                Text("• "+occupation)
                                    .font(.subheadline)
                            }
                            Divider()
                            Text("Knickanme")
                            if !character.aliases.isEmpty {
                                ForEach(character.aliases, id: \.self) { alias in
                                    Text("‣ "+alias)
                                        .font(.subheadline)
                                }
                            }else {
                                Text("None")
                                    .font(.subheadline)
                            }
                            Divider()
                            DisclosureGroup("Character Status"){
                                VStack (alignment:. leading){
                                    Text(character.status)
                                    
                                    if character.death != nil {
                                        AsyncImage(url: URL(string: character.death!.image)!) {
                                            image in
                                            image.resizable()
                                                .scaledToFit()
                                                .clipShape(.rect(cornerRadius: 20))
                                                .onAppear {
                                                    withAnimation {
                                                        proxy.scrollTo(1, anchor: .bottom)
                                                    }
                                                }
                                        }placeholder: {
                                            ProgressView()
                                        }
                                        Text("How: \(character.death?.cause ?? "N/A")")
                                            .font(.subheadline)
                                            .padding(.bottom)
                                        
                                        Text("Last words : \(character.death?.lastWords ?? "N/A")")
                                            .font(.subheadline)
                                    }
                                }
                                .frame(maxWidth: geo.size.width, alignment: .leading)
                            }
                            .tint(.breakingBad)
                            .id(1)
                            .padding(.bottom)
                        }
                    }
                    .frame(width: geo.size.width * 0.8)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CharacterView(character: ViewModel().character!, show: Constants.bbName)
}
