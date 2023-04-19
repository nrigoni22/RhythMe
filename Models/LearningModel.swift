import Foundation

struct LearningModel: Identifiable {
    var id: String {
        guard let noteType else { return "Click" }
        return noteType.rawValue
    }
    var soundTrack: String {
        id
    }
    var isPlaying: Bool
    let noteType: NoteType?
    let description: String
    
    init(isPlaying: Bool = false, noteType: NoteType? = nil, description: String) {
        self.isPlaying = isPlaying
        self.noteType = noteType
        self.description = description
    }
    
    static let example = LearningModel(description: "Listen only the clicker and get the beat")
}
