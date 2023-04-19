import SwiftUI

struct LevelsEndedView: View {
    
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
            
            VStack(spacing: 10) {
                Image(systemName: "music.quarternote.3")
                    .font(.system(size: 100.0))
                    .foregroundColor(.black)
                    .padding(.top, 40)
                Spacer()
                Text("You've completed all the levels, do you want to start over?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom)
                Spacer()
                Button(action: {
                    levelData.resetAllLevels()
                }, label: {
                    Text("Restart")
                })
                
                Button(action: {
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

struct LevelsEndedView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsEndedView(navigationSelection: .constant(nil))
            .environmentObject(LevelData())
    }
}
