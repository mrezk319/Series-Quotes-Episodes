import Foundation

// MARK: - CharacterModel
struct CharacterModel: Codable {
    let characterId: Int
    let name, birthday: String
    let occupations: [String]
    let images: [String]
    let fullName: String
    let aliases: [String]
    let status: String
    let appearance: Appearance
    let portrayedBy: String
    let productions: [String]
    var death: DeathModel?
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.characterId = try container.decode(Int.self, forKey: .characterId)
        self.name = try container.decode(String.self, forKey: .name)
        self.birthday = try container.decode(String.self, forKey: .birthday)
        self.occupations = try container.decode([String].self, forKey: .occupations)
        self.images = try container.decode([String].self, forKey: .images)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.aliases = try container.decode([String].self, forKey: .aliases)
        self.status = try container.decode(String.self, forKey: .status)
        self.appearance = try container.decode(Appearance.self, forKey: .appearance)
        self.portrayedBy = try container.decode(String.self, forKey: .portrayedBy)
        self.productions = try container.decode([String].self, forKey: .productions)
//        self.death = try container.decodeIfPresent(DeathModel.self, forKey: .death)
        let jsonDeath = try! Data(contentsOf: Bundle.main.url(forResource: "sampledeath", withExtension: "json")!)  
        self.death = try! JSONDecoder().decode(DeathModel.self,from: jsonDeath)
    }
    enum CodingKeys: String, CodingKey {
        case characterId = "character_id"
        case name, birthday, occupations, images
        case fullName = "full_name"
        case aliases, status, appearance
        case portrayedBy = "portrayed_by"
        case productions
        case death
    }
}

// MARK: - Appearance
struct Appearance: Codable {
    let breakingBad, betterCallSaul, elCamino: [Int]
    
    enum CodingKeys: String, CodingKey {
        case breakingBad = "breaking_bad"
        case betterCallSaul = "better_call_saul"
        case elCamino = "el_camino"
    }
}
