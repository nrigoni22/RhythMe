import SwiftUI
import AVFoundation

class LevelData: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var noteCard: [CardModel] = [
        CardModel(noteType: .whole),
        CardModel(noteType: .half),
        CardModel(noteType: .quarter),
        CardModel(noteType: .eight),
        CardModel(noteType: .sixteenth)
    ]
    
    @Published var composedRithmPhrase: [CardModel] = []
    
    @Published var levels: [LevelModel] = []
    
    let initialLevels: [LevelModel] = [
        .init(id: 1, rhythmPhraseNotes: [.quarter, .quarter, .quarter, .quarter], composerInfo: "Wolfgang A. Mozart", trackInfo: "Canzonetta"),
        .init(id: 2, rhythmPhraseNotes: [.half, .eight, .eight, .eight, .eight], composerInfo: "Johann S. Bach", trackInfo: "Arioso"),
        .init(id: 3, rhythmPhraseNotes: [.eight, .eight, .eight, .eight, .eight, .eight, .eight, .eight], composerInfo: "Ludwig V. Beethoven", trackInfo: "Für Elise"),
        .init(id: 4, rhythmPhraseNotes: [.eight, .sixteenth, .sixteenth, .eight, .eight, .eight, .eight, .eight, .eight], composerInfo: "Peter I. Tchaikovsky", trackInfo: "Trepak")
    ]
    
    @Published var selectedCard: CardModel? = nil
    @Published var cardIsOver: Bool = false
    
    @Published var currentLevel: Int = 0
    @Published var showLevelCompeleteView: Bool = false
    @Published var showEndLevelsView: Bool = false
    @Published var isPlaying: Bool = false
    @Published var showHintButton: Bool = false
    @Published var showHint: Bool = false
    
    let soundManager: SoundManager = SoundManager.instance
    let persistanceManager: PersistanceManager = PersistanceManager.instance
    
    var destinationFrame: CGRect? = nil
    
    var lastLevel: Bool {
        guard currentLevel == levels.count - 1 else { return true }
        return false
    }
    
    var validateLevel: Bool {
        for index in 0..<composedRithmPhrase.count {
            if composedRithmPhrase[index].noteType != levels[currentLevel].rhythmPhraseNotes[index] {
                return false
            }
        }
        return true
    }
    
    var getLevelBadgeInfo: BadgeModel {
        levels[currentLevel].badge
    }
    
    var getLevelinfo: LevelModel {
        levels[currentLevel]
    }
    
    var getLevelRhythmTrackName: String {
        levels[currentLevel].rhythmPhraseMusic
    }
    
    private var allLevelsCompleted: Bool {
        guard let lastLevel = levels.last, lastLevel.isCompleted else { return false }
        return true
    }
    
    override init() {
        super.init()
        fetchLevel()
        createLevelCardContainer()
    }
    
    private func fetchLevel() {
        guard let levels: [LevelModel] = persistanceManager.read(filename: "Level.json") else { 
            self.levels = initialLevels
            return 
        }
        self.levels = levels
        guard let currentLevel = levels.firstIndex(where: { $0.isCompleted == false }) else { 
            showEndLevelsView = true
            return 
        }
        self.currentLevel = currentLevel
    }
    
    func updatePosition(_ value: DragGesture.Value, card: CardModel) {
        guard let index = noteCard.firstIndex(where: { $0.id == card.id }), !showLevelCompeleteView else { return }
        
        if abs(value.translation.width) < (noteCard[index].cardWidth / 2) &&  abs(value.translation.height) < (noteCard[index].cardHeight / 2) && selectedCard == nil {
            noteCard[index].position = value.translation
        } else {
            noteCard[index].position = .zero
            if selectedCard == nil {
                selectedCard = noteCard[index]
                let x: CGFloat = value.startLocation.x + card.cardWidth / 2
                let y: CGFloat = value.startLocation.y - card.cardHeight / 2
                selectedCard?.initialPosition = CGPoint(x: x, y: y)
            } else { 
                selectedCard?.position = value.translation
                guard let destinationFrame else { return }
                let location = value.location
                if location.x > destinationFrame.minX && location.x < destinationFrame.maxX && location.y < destinationFrame.maxY && location.y > destinationFrame.minY {
                    cardIsOver = true
                } else {
                    cardIsOver = false
                }
            }
        }
    }
    
    func checkCompletedLevels() {
       if allLevelsCompleted {
           showEndLevelsView = true
       }
    }
    
    private func createLevelCardContainer() {
        composedRithmPhrase = []
        composedRithmPhrase = Array(repeating: CardModel(), count: levels[currentLevel].rhythmPhraseNotes.count)
    }
    
    func nextLevel() {
        guard lastLevel else { return }
        withAnimation(.easeInOut) { 
            showLevelCompeleteView = false
            currentLevel += 1
        }
        
        createLevelCardContainer()
        
    }
    
    func resetAllLevels() {
        currentLevel = 0
        levels = initialLevels
        createLevelCardContainer()
        persistanceManager.write(array: levels, filename: "Level.json")
        withAnimation(.easeInOut) { 
            showEndLevelsView = false
        }
    }
    
    func addCardToPhrase() {
        guard cardIsOver  else {
            withAnimation(.easeInOut) { 
                self.selectedCard = nil
            }
            
            return 
        }
        
        guard let selectedCard else { return }
        
        guard let cardIndex = composedRithmPhrase.firstIndex(where: { $0.noteType == nil }) else {
            withAnimation(.easeInOut) { 
                cardIsOver = false
                self.selectedCard = nil
               
            }
             return 
        }
        
        withAnimation(.easeInOut) { 
            composedRithmPhrase[cardIndex] = selectedCard
            composedRithmPhrase[cardIndex].id = UUID()
            showHintButton = false
            showHint = false
        }
        
        if cardIndex == levels[currentLevel].rhythmPhraseNotes.count - 1 {
            
            if validateLevel {
                levels[currentLevel].completedAt = Date.now
                persistanceManager.write(array: levels, filename: "Level.json")
            }
            
            withAnimation(.interpolatingSpring(stiffness: 15, damping: 8).delay(0.5)) { 
                showLevelCompeleteView = true
            } 
        }
        
        self.selectedCard = nil
        cardIsOver = false
        
    }
    
    func removeCardToPhrase(card: CardModel) {
        guard let index = composedRithmPhrase.firstIndex(where: { $0.id == card.id }) else { return }
        withAnimation(.easeInOut) { 
             composedRithmPhrase[index] = CardModel()
        }
    }
    
    func resetLevel() {
        withAnimation(.easeInOut) { 
            showLevelCompeleteView = false
        }
        withAnimation(.easeInOut.delay(0.5)) { 
            showHintButton = true
        }
        createLevelCardContainer()
    }
    
    func playTrack(_ name: String) {
        stopPlaying()
        soundManager.playSound(sound: name)
        soundManager.player?.delegate = self
        isPlaying = true
    }
    
    func stopPlaying() {
        soundManager.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
}
