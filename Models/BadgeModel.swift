import SwiftUI

struct BadgeModel: Identifiable, Codable {
    let id: Int
    var musicTrack: String {
        "Track\(id)"
    }
    var badgeImageName: String {
        "Badge\(id)"
    }
    let gotAt: Date
    let composerInfo: String
    let trackInfo: String
    
    static let example = BadgeModel(id: 1, gotAt: Date.now, composerInfo: "Chopin", trackInfo: "Prelude in C Major")
}
