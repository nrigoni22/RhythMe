import SwiftUI

struct BadgesView: View {
    @EnvironmentObject private var levelData: LevelData
    @Binding var navigationSelection: NavigationSelection?
    
    var body: some View {
        VStack(spacing: 0) {
            
            Button(action: {
                withAnimation(.easeInOut) { 
                    navigationSelection = nil
                }
            }, label: {
                BackButton()
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            
            VStack(spacing: 10) {
                Text("Are you courious to discorver what is the puzzle about? Do some practice, and discover it!")
                    .font(.title)
                    .foregroundColor(.white)
                Text("Once unlocked, tap on each tile puzzle to see some details")
                    .font(.subheadline)
                    .foregroundColor(.white) 
            }
            
            Spacer()
            
            ForEach(0..<2, id: \.self) { row in
            HStack(spacing: 0) {
                ForEach(0..<2, id: \.self) { column in
                        let indexCard = row * 2 + column
                    let level = levelData.levels[indexCard]
                        if level.isCompleted {
                            BadgeCardView(badge: level.badge, isPlaying: levelData.isPlaying) { 
                                levelData.playTrack(level.badge.musicTrack)
                            }
                        } else {
                            emptyCard
                                .overlay(alignment: .center) {
                                    VStack {
                                        Text("Level")
                                            .bold()
                                        Text("\((indexCard + 1).formattedLevel)")
                                    }
                                    .font(.title)
                                    .foregroundColor(.black)
                                }
                        }
                    }
                }
            } 
            Spacer()
        }
    }
}

struct BadgesView_Previews: PreviewProvider {
    static var previews: some View {
        BadgesView(navigationSelection: .constant(nil))
            .environmentObject(LevelData())
    }
}

extension BadgesView {
    private var emptyCard: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: 300, height: 300)
            .overlay(
                Rectangle()
                    .stroke(Color.black, lineWidth: 1.5)
            ) 
    }
}
