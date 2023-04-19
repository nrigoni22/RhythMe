import SwiftUI

struct LearningCardView: View {
    let cardData: LearningModel
    let performPlay: () -> ()
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 15) {
            Button(action: {
                performPlay()
            }, label: {
                if let noteType = cardData.noteType {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(noteType.color.gradient)
                            .frame(width: 100, height: 150)
                        VStack(spacing: 15) {
                            Image(systemName: cardData.isPlaying ? "stop.fill" : "play.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                            Image(noteType.rawValue)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 60)
                        }
                    }
                } else {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white)
                            .frame(width: 100, height: 150)
                        VStack(spacing: 15) {
                            Image(systemName: cardData.isPlaying ? "stop.fill" : "play.fill")
                                .font(.title3)
                                .foregroundColor(.black)
                            Image(systemName: "waveform.path.ecg")
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.black)
                                .shadow(color: .black, radius: 15, x: 0.0, y: 0.0)
                                
                        }
                    }
                }
            }) 
            
            Text(cardData.description)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
            
        }
        .padding()
        .frame(minWidth: 350, maxWidth: 500)
        .background(
            .thinMaterial,
            in: RoundedRectangle(cornerRadius: 15, style: .continuous)
        )
    }
}

struct LearningCardView_Previews: PreviewProvider {
    static var previews: some View {
        LearningCardView(cardData: LearningModel.example) { 
            print("play")
        }
    }
}
