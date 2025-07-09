//
//  EpisodeView.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 09/07/2025.
//

import SwiftUI

struct EpisodeView: View {
    let episode: EpisodeModel
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment:.leading){
                Text(episode.title)
                    .font(.title)
                    .padding(.top)
                Text(episode.seasonEpisode)
                    .font(.subheadline)
                AsyncImage(url: URL(string: episode.image)!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(.rect(cornerRadius: 15))
                } placeholder: {
                    HStack (alignment:.center) {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: geometry.size.height * 0.4,alignment: .center)
                Text(episode.synopsis)
                    .font(.subheadline)
                    .padding(.vertical)
                
                Text("Written By : "+episode.writtenBy)
                    .font(.subheadline)
                Text("Directed By : "+episode.directedBy)
                    .font(.subheadline)
                Text("Aired : "+episode.airDate)
                    .font(.subheadline)
                    .padding(.bottom)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color.black.cornerRadius(15).opacity(0.6))
            .padding()
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    EpisodeView(episode: ViewModel().episode!)
}
