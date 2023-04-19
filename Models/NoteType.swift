import SwiftUI

enum NoteType: String, CaseIterable, Codable {
    case whole = "Whole"
    case half = "Half"
    case quarter = "Quarter"
    case eight = "Eight"
    case sixteenth = "Sixteenth"
    case thirtySecond = "ThirtySecond"
    
    var color: Color {
        switch self {
        case .whole:
             return .orange
        case .half:
             return .blue
        case .quarter:
           return .green
        case .eight:
            return .teal
        case .sixteenth:
            return .pink
        case .thirtySecond:
           return .purple
        }
    }
}

