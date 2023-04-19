import Foundation


extension Int {
    var formattedLevel: String {
        if self < 10 {
            return "0\(self)"
        } else {
            return "\(self)"
        }
    }
}

