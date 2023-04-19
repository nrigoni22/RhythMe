import SwiftUI

struct LevelModel: Identifiable, Codable {
    let id: Int
    var rhythmPhraseMusic: String {
        "Rhythm\(id)"
    }
    let rhythmPhraseNotes: [NoteType]
    var completedAt: Date? = nil
    var isCompleted: Bool {
        guard completedAt != nil else { return false }
        return true
    }
    var backgroundImageName: String {
        "Theater\(id)"
    }
    var badge: BadgeModel
    
    init(id: Int, rhythmPhraseNotes: [NoteType], composerInfo: String, trackInfo: String) {
        self.id = id
        self.rhythmPhraseNotes = rhythmPhraseNotes
        self.badge = BadgeModel(id: id, gotAt: completedAt ?? Date.now, composerInfo: composerInfo, trackInfo: trackInfo)
        
    }
    
    static let example = LevelModel(id: 1, rhythmPhraseNotes: [.half, .quarter, .quarter, .sixteenth], composerInfo: "Chopin", trackInfo: "Prelude in C Major")
    
}
