import SwiftUI

struct WelcomeView: View {
    @Binding var navigationSelection: NavigationSelection?
    
    var body: some View {
        
        VStack {
            Spacer()
            Text("Meet the rhythm")
                .modifier(WelcomeCardModifier(imageName: "ear.and.waveform"))
                .onTapGesture {
                    withAnimation(.easeInOut) { 
                        navigationSelection = .learning
                    }
                }
            Spacer()
            Text("Do some practice")
                .modifier(WelcomeCardModifier(imageName: "music.quarternote.3"))
                .onTapGesture {
                    withAnimation(.easeInOut) { 
                        navigationSelection = .practice
                    }
                }
            Spacer()
            Text("Badges")
                .modifier(WelcomeCardModifier(imageName: "puzzlepiece.extension"))
                .background(
                    RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                )
                .onTapGesture {
                    withAnimation(.easeInOut) { 
                        navigationSelection = .badges
                    }
                }
            Spacer()
        } 
        
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(navigationSelection: .constant(nil))
    }
}
