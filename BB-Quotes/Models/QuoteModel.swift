import Foundation

// MARK: - QuoteModel
struct QuoteModel: Codable {
    let quoteId: Int
    let quote, character, production: String
    let episode: Int
    
    enum CodingKeys: String, CodingKey {
        case quoteId = "quote_id"
        case quote, character, production, episode
    }
}
