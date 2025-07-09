//
//  Services.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 07/07/2025.
//

import Foundation


class FetchData {
    
    enum FetchError: Swift.Error {
        case badResoponse
    }
    let baseURL = URL(string: "https://breaking-bad-api-six.vercel.app/api/")!
    
    ///
    /// https://breaking-bad-api-six.vercel.app/api/quotes/random?production=Breaking+Bad
    ///
    func fetchRandomQuote(val value: String) async throws -> QuoteModel {
        let quoteURL = baseURL.appendingPathComponent("quotes/random")
        let fetchURL = quoteURL.appending(queryItems: [URLQueryItem(name: "production", value: value)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL);
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResoponse
        }
        
        let decoder = JSONDecoder()
        return try decoder.decode(QuoteModel.self, from: data)
         
    }
    
    func fetchCharacter(val value: String) async throws -> CharacterModel {
        let characterURL = baseURL.appendingPathComponent("characters")
        let fetchURL = characterURL.appending(queryItems: [URLQueryItem(name: "name", value: value)])
        
        let (data, response) = try await URLSession.shared.data(from: fetchURL);
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResoponse
        }
        
        let decoder = JSONDecoder()
        let chars = try decoder.decode([CharacterModel].self, from: data)
        return chars[0]
    }
     
    func fetchDeaths(character value: String) async throws -> DeathModel? {
        let fetchURL = baseURL.appendingPathComponent("deaths")
         
        let (data, response ) = try await URLSession.shared.data(from: fetchURL);
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResoponse
        }
        
        let decoder = JSONDecoder()
        let deaths = try decoder.decode([DeathModel].self, from: data)
        for death in deaths {
            if death.character.localizedCaseInsensitiveContains(value)  {
                return death
            }
        }
        return nil
    }
    
    func fetchEpisode(from  show: String) async throws -> EpisodeModel? {
        let episodeURL = baseURL.appendingPathComponent("episodes")
        let fetchURL = episodeURL.appending(queryItems: [URLQueryItem(name: "production", value: show)])
        
        let (data, response ) = try await URLSession.shared.data(from: fetchURL);
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FetchError.badResoponse
        }
        
        let decoder = JSONDecoder()
        let episodes = try decoder.decode([EpisodeModel].self, from: data)
        return episodes.randomElement()
    }
}
