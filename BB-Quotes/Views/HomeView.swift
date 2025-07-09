//
//  QuoteView.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 07/07/2025.
//

import SwiftUI

struct HomeView: View {
    var vm = ViewModel()
    let show: String
    
    var body: some View {
        ZStack {
                Image(show.lowercased().replacingOccurrences(of: " ", with:""))
                    .resizable()
                    .ignoresSafeArea()
            
                VStack {
                    Spacer()
                    switch vm.status {
                    case .loading:
                        EmptyView()
                    case .loadedEpisode:
                        EpisodeView(episode: vm.episode!)
                    case .idle,.loadedQuote:
                        QuoteView(vm: vm, show: show)
                    case .failed(let error):
                        Text(error.localizedDescription)
                    }
                    ButtonsViews()
                }
        }
    }
}

#Preview {
    HomeView(show: Constants.bbName)
}

extension HomeView {
    func ButtonsViews() -> some View {
            HStack{
                Button {
                    Task {
                        await vm.fetchQuote(val: show)
                    }
                } label: {
                    Text("Get Random Quote")
                        .font(.subheadline)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Color"))
                        .clipShape(.buttonBorder)
                        .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                }
                Spacer()
                Button {
                    Task {
                        await vm.fetchEpisode(val: show)
                    }
                } label: {
                    Text("Get Random Episode")
                        .font(.subheadline)
                        .padding()
                        .foregroundStyle(.white)
                        .background(Color("\(show.replacingOccurrences(of: " ", with: ""))Color"))
                        .clipShape(.buttonBorder)
                        .shadow(color: Color("\(show.replacingOccurrences(of: " ", with: ""))Shadow"), radius: 2)
                }
            }
            .padding()
        }
}
