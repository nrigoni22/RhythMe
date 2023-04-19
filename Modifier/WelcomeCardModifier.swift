import SwiftUI

struct WelcomeCardModifier: ViewModifier {
    let imageName: String
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(maxWidth: 600, maxHeight: 250, alignment: .center)
            .background(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .foregroundColor(.white)
                    .shadow(color: Color(hex: 0x2C3333), radius: 20, x: -20, y: 20)
                    .overlay(alignment: .trailing, content: { 
                        Image(systemName: imageName)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.blue.opacity(0.1))
                            .padding(20)
                    })
            )
    }
}
