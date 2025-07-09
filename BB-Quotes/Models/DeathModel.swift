import Foundation

// MARK: - DeathModel
struct DeathModel: Codable {
    let deathId: Int
    let character: String
    let image: String
    let cause, details: String
    let responsible, connected: [String]
    let lastWords: String
    let episode: Int
    let production: String
    
    enum CodingKeys: String, CodingKey {
        case deathId = "death_id"
        case character, image, cause, details, responsible, connected
        case lastWords = "last_words"
        case episode, production
    }
}
