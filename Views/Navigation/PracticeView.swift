import SwiftUI

struct PracticeView: View {
    @EnvironmentObject private var levelData: LevelData
    @GestureState private var dragOffset = CGSize.zero
    @Binding var navigationSelection: NavigationSelection?
    @State private var selectedCardID: UUID? = nil
    
    init(navigationSelection: Binding<NavigationSelection?>) {
        self._navigationSelection = navigationSelection
    }
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                    levelData.resetLevel()
                    
                    withAnimation(.easeInOut) { 
                        navigationSelection = nil
                    }
                }, label: {
                    BackButton()
                    
                })
                Spacer()
                
                if !levelData.showEndLevelsView {
                    Text("\((levelData.currentLevel + 1).formattedLevel)/\(levelData.levels.count.formattedLevel)")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }  
            }
            .padding()
            
            Spacer()
            
            if !levelData.showEndLevelsView {
                Button(action: {
                    levelData.playTrack(levelData.getLevelRhythmTrackName)
                }, label: {
                    HStack {
                        Image(systemName: levelData.isPlaying ? "stop.fill" : "play.fill")
                        Text("Listen")
                            .bold()
                    }
                    .font(.title)
                    .padding()
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .foregroundColor(.white)
                    )
                })
                
                Button(action: {
                    withAnimation(.easeInOut) { 
                        levelData.showHint.toggle()
                    }
                    
                }, label: {
                    HStack {
                        Image(systemName: "questionmark")
                        Text("Hint")
                    }
                    .font(.title)
                    .bold()
                    .padding()
                    .foregroundColor(.black)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color.yellow.gradient)
                    )
                })
                .padding(.top)
                .opacity(levelData.showHintButton ? 1 : 0)
                
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(0..<levelData.composedRithmPhrase.count, id: \.self) { index in
                        
                        NoteCardView(card: levelData.composedRithmPhrase[index], enableRemove: true, selectedCardID: levelData.composedRithmPhrase[index].id) {
                            levelData.removeCardToPhrase(card: levelData.composedRithmPhrase[index]) 
                            
                        }
                        .overlay(alignment: .center) { 
                            if levelData.showHint {
                                Image(levelData.getLevelinfo.rhythmPhraseNotes[index].rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(43)
                                    .opacity(0.5)
                            }
                        } 
                    }     
                }
                .padding(3)
                .background(
                    GeometryReader { geometry -> RoundedRectangle in
                        levelData.destinationFrame = geometry.frame(in: .named("screen"))
                        return RoundedRectangle(cornerRadius: 15.0, style: .continuous)  
                    }
                )
                .overlay( 
                    RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                        .stroke(levelData.cardIsOver ? Color.green : Color.clear, style: StrokeStyle(lineWidth: 5))
                        .animation(.easeInOut, value: levelData.cardIsOver)
                )
                
                Spacer()
                
                HStack {
                    ForEach(levelData.noteCard) { card in
                        NoteCardView(card: card) {
                            
                        }
                        .offset(x: card.position.width, y: card.position.height)
                        .gesture(
                            DragGesture(coordinateSpace: .named("screen"))
                                .updating($dragOffset, body: { value, state, transaction in
                                    state = value.translation
                                    
                                    levelData.updatePosition(value, card: card)
                                    
                                })
                                .onEnded({ (value) in
                                    levelData.addCardToPhrase()
                                })
                        )
                        
                    } 
                }
                .padding()  
            }
        }
        .coordinateSpace(name: "screen")
        .onAppear(perform: {
            levelData.checkCompletedLevels()
        })
        .overlay(alignment: .center) {
            if let selectedCard = levelData.selectedCard {
                NoteCardView(card: selectedCard, enableRemove: false) {
                    
                }
                .position(x: selectedCard.initialPosition.x, y: selectedCard.initialPosition.y) 
                .offset(x: selectedCard.position.width, y: selectedCard.position.height)
            }
            
            if levelData.showLevelCompeleteView {
                LevelCompletedView(navigationSelection: $navigationSelection)
                    .frame(minWidth: 300, maxWidth: 600, minHeight: 300, maxHeight: 600)
            }
            
            if levelData.showEndLevelsView {
                LevelsEndedView(navigationSelection: $navigationSelection)
                    .frame(minWidth: 300, maxWidth: 600, minHeight: 300, maxHeight: 600)
            }
        }
        .background(
            Image(levelData.getLevelinfo.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView(navigationSelection: .constant(nil))
            .environmentObject(LevelData())
    }
}
