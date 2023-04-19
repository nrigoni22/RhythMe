import Foundation

class LearningData: ObservableObject {
    
    @Published var learningCards: [LearningModel] = [
        LearningModel(description: "Hear the click and get the beat."),
        LearningModel(noteType: .whole, description: "The whole note has the longest note duration in modern music."),
        LearningModel(noteType: .half, description: "The half note has half the duration of a whole note, two half notes occupy the same amount of time as one whole note."),
        LearningModel(noteType: .quarter, description: "The quarter note is a fourth (or quarter) of a whole note, four quarter notes occupy the same amount of time as one whole note. Two quarter notes equal the duration of a half note."),
        LearningModel(noteType: .eight, description: "Two eighth notes occupy the same amount of time as one quarter note."),
        LearningModel(noteType: .sixteenth, description: "Two sixteenth notes equal the duration of an eighth note, four sixteenth notes occupy the same amount of time as one quarter note.")
    ]
    
    
    private let soundManager: SoundManager = SoundManager.instance
    
    func playTrack(learningModel: LearningModel) {
        if learningModel.isPlaying {
            stopPlayng()
            return
        }
        stopPlayng()
        guard let index = learningCards.firstIndex(where: { $0.id == learningModel.id }) else { return }
        learningCards[index].isPlaying = true
        soundManager.playSound(sound: learningCards[index].soundTrack, numOfLoop: -1)
    }
    
    func stopPlayng() {
        if let index = learningCards.firstIndex(where: { $0.isPlaying == true }) {
            learningCards[index].isPlaying = false
            soundManager.stop() 
        }
    }
}

