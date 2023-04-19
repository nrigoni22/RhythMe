import SwiftUI

enum NavigationSelection {
    case learning, practice, badges
}

@main
struct MyApp: App {
    @State private var  navigationSelection: NavigationSelection? = nil
    @StateObject private var levelData = LevelData()
    private let backgroundColors: [Color] = [.cyan, .blue, .indigo] //[Color(hex: 0x57C5B6), Color(hex: 0x159895), Color(hex: 0x1A5F7A)]//[.cyan, .blue, .indigo]
        
    var body: some Scene {
        WindowGroup {
            ZStack {
                LinearGradient(colors: backgroundColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                if navigationSelection == nil {
                    WelcomeView(navigationSelection: $navigationSelection)
                        .transition(.move(edge: .trailing))
                } else if navigationSelection == .learning {
                    LearningView(navigationSelection: $navigationSelection)
                        .transition(.move(edge: .trailing))
                } else if navigationSelection == .practice {
                    PracticeView(navigationSelection: $navigationSelection)
                        .environmentObject(levelData)
                        .transition(.move(edge: .trailing))
                } else {
                    BadgesView(navigationSelection: $navigationSelection)
                        .environmentObject(levelData)
                        .transition(.move(edge: .trailing)) 
                }
            }
           
            
        }
    }
}
