//
//  EpisodeModel.swift
//  BB-Quotes
//
//  Created by Muhammed Rezk Rajab on 09/07/2025.
//

import Foundation

// MARK: - EpisodeModel
struct EpisodeModel: Codable {
    let episodeId: Int
    let production: String
    let episode: Int
    let title: String
    let image: String
    let synopsis, writtenBy, directedBy, airDate: String
    let characters: [String]
    var seasonEpisode: String {
        "Season \(episodeId / 100) Episode \(episodeId % 100)"
    }
    enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case production, episode, title, image, synopsis
        case writtenBy = "written_by"
        case directedBy = "directed_by"
        case airDate = "air_date"
        case characters
    }
}
