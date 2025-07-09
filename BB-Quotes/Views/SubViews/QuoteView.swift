//
//  QuoteView.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 09/07/2025.
//

import SwiftUI

struct QuoteView: View {
    let vm: ViewModel
    let show: String
    @Namespace var animation
    var body: some View {
        GeometryReader {
            geo in
            VStack (alignment: .center){
                Text(vm.quote?.quote ?? "")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .bold()
                    .padding()
                    .multilineTextAlignment(.center)
                    .background(
                        .black.opacity(0.2)
                    )
                    .clipShape(.rect(cornerRadius: 20))
                ZStack (alignment: .bottom) {
                    NavigationLink {
                        CharacterView(character: vm.character!, show: show)
                            .navigationTransition(.zoom(
                                sourceID: 1, in: animation
                            ))
                    } label: {
                        AsyncImage(url: URL(string: vm.character?.images.randomElement() ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            case .failure(let error):
                                VStack {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                    Text("Failed to load image")
                                    Text(error.localizedDescription)
                                }
                                
                            @unknown default:
                                ProgressView()
                            }
                        }
                    }

                    .matchedTransitionSource(id: 1, in: animation)
                    .frame(width: geo.size.width * 0.9,
                           height: geo.size.height * 0.78)
                    Text(vm.character?.name ?? "")
                        .frame(maxWidth: geo.size.width * 0.9)
                        .padding(5 )
                        .foregroundStyle(.white)
                        .background(.ultraThinMaterial)
                        .font(.title2)
                    
                }
                .clipShape(.rect(cornerRadius: 20))
            }
            .frame(maxWidth: geo.size.width * 0.9)
            .frame(maxWidth: geo.size.width, alignment: .center)
        }
    }
}

#Preview {
    QuoteView(vm: ViewModel(), show: Constants.bbName)
}
