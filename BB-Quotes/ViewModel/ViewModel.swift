//
//  ViewModel.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 07/07/2025.
//

import Foundation
@Observable
@MainActor // 3shan h update 3la 7aga t render f el UI fa b2olo run this on Main Thread
class ViewModel {
    enum FetchStatus {
        case idle
        case loading
        case loadedEpisode
        case loadedQuote
        case failed(Error)
    }
    
    private(set) var status: FetchStatus = .idle
    
    private var fetcher: FetchData = FetchData()
    
    var quote: QuoteModel?
    var character: CharacterModel?
    var episode: EpisodeModel?
    
    init(){
        let jsonQuote = Bundle.main.url(forResource: "samplequote", withExtension: "json")!
        let jsonCharacter = Bundle.main.url(forResource: "samplecharacter", withExtension: "json")!
        let episodeCharacter = Bundle.main.url(forResource: "sampleepisode", withExtension: "json")!
        quote = try? JSONDecoder().decode(QuoteModel.self, from: Data(contentsOf: jsonQuote))
        character = try? JSONDecoder().decode(CharacterModel.self, from: Data(contentsOf: jsonCharacter))
        episode  = try? JSONDecoder().decode(EpisodeModel.self, from: Data(contentsOf: episodeCharacter))
    }

    func fetchQuote(val:String) async {
        status = .loading
        do {
            let fetchedQuote = try await fetcher.fetchRandomQuote(val: val)
            let characterName = fetchedQuote.character
            var fetchedCharacter = try await fetcher.fetchCharacter(val: characterName)
            let name = fetchedCharacter.name
            fetchedCharacter.death = try await fetcher.fetchDeaths(character: name)
            
            self.quote = fetchedQuote
            self.character = fetchedCharacter
            self.status = .loadedQuote
        } catch {
            self.status = .failed(error)
        }
    }
     
    func fetchEpisode(val:String) async {
        status = .loading
        do {
            if let fetchedEpisode = try await fetcher.fetchEpisode(from: val) {
                episode  = fetchedEpisode
            }
            self.status = .loadedEpisode
        } catch {
            self.status = .failed(error)
        }
    }
    
}
