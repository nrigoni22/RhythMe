import SwiftUI

struct CardModel: Identifiable, Equatable {
    var id = UUID()
    let noteType: NoteType?
    var position: CGSize = .zero
    var initialPosition: CGPoint = CGPoint(x: 0.0, y: 0.0)
    var color: Color {
        guard let noteType else { return Color.white }
        return noteType.color
    }
    let cardWidth: CGFloat = 100
    let cardHeight: CGFloat = 150
    
    init(noteType: NoteType? = nil) {
        self.noteType = noteType
    }
    
    static let example = CardModel(noteType: .whole)
}
