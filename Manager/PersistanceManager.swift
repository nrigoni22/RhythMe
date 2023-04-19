import SwiftUI

class PersistanceManager {
    static let instance = PersistanceManager()
    
    
    func read<T: Codable>(filename: String) -> T? {
        var file: URL
        var data: Data?
        
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
        } catch {
            fatalError("Coudn't read or create \(filename): \(error.localizedDescription)")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            print("Couldn't load \(filename) from main bundle or document directory :\n\(error)")
        }
        
        guard data != nil else { return nil }
        
        do {
            let decoder = JSONDecoder()
            print("Reading \(file.description)")
            return try decoder.decode(T.self, from: data!)
        } catch {
            print("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
        return nil
    }
    
    func write<T: Codable>(array: [T], filename: String) {
        var file: URL
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            file = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(filename)
            print("Writing \(file.description)")
            try encoder.encode(array).write(to: file)
        } catch {
            print("error writing \(filename): \(error.localizedDescription)")
        }
    }


}
