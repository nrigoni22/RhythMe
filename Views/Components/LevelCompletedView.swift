import SwiftUI

struct LevelCompletedView: View {
    
    @EnvironmentObject var levelData: LevelData
    
    @Binding var navigationSelection: NavigationSelection?
    
    init(navigationSelection: Binding<NavigationSelection?>) {
        self._navigationSelection = navigationSelection
    }
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 10, x: 0.0, y: 0.0)
//                .frame(width: 600, height: 600)
            
            if levelData.validateLevel {
                VStack(spacing: 10) {
                    Image(levelData.getLevelBadgeInfo.badgeImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .padding(.bottom, 40)
                    
                    Text("Congrats, you got it!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    
                    Text("Listen the rhythm from:")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    
                    Text(levelData.getLevelBadgeInfo.trackInfo)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("by")
                        .font(.subheadline)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    
                    Text(levelData.getLevelBadgeInfo.composerInfo)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    
                    Button(action: {
                        levelData.playTrack(levelData.getLevelBadgeInfo.musicTrack)
                    }, label: {
                        HStack {
                            Image(systemName: levelData.isPlaying ? "stop.fill" : "play.fill")
                            Text("Listen")
                        }
                        .padding()
                    })
                    .padding(.bottom, 40) 
                    .buttonStyle(.bordered)
                    
                    if levelData.lastLevel {
                        Button(action: {
                            levelData.nextLevel()
                        }, label: {
                            Text("Next level")
                        }) 
                    }
                   
                    
                    Button(action: {
                        
                        levelData.resetLevel()
                        levelData.nextLevel()
                        withAnimation(.easeInOut) { 
                            navigationSelection = nil
                        }
                    }, label: {
                        Text("Exit")
                    })
                    
                }
                
            } else {
                VStack(spacing: 10) {
                    Text("☹️")
                        .font(.system(size: 100.0))
                        .shadow(color: .orange, radius: 15, x: 0.0, y: 0.0)
                        .padding(.top, 40)
                    Spacer()
                    Text("Ops, the rhythm is not matching")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom)
                    Spacer()
                    Button(action: {
                        levelData.resetLevel()
                    }, label: {
                        Text("Try again")
                    })
                    
                    Button(action: {
                        
                        levelData.resetLevel()
                        
                        withAnimation(.easeInOut) { 
                            navigationSelection = nil
                        }
                    }, label: {
                        Text("Exit")
                            .padding(.bottom, 40)
                    })
                }
            }
        }
    }
}

struct LevelCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        LevelCompletedView(navigationSelection: .constant(nil))
            .environmentObject(LevelData())
    }
}
