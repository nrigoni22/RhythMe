import SwiftUI

struct BadgeCardView: View {
    
    let badge: BadgeModel
    @State private var isFlipped: Bool = false
    let axis:(CGFloat,CGFloat,CGFloat) = (0.0,1.0,0.0)
    let isPlaying: Bool
    let performPlay: () -> ()
    
    
    var body: some View {
        
        ZStack {
            if !isFlipped {
                notFlippedView
            } else {
                flippedView
                    .rotation3DEffect(
                        .degrees(isFlipped ? 180 : 0),
                        axis: axis,
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0
                    )
            }
        }
        .onTapGesture {
            withAnimation(.linear(duration: 2.0)) { 
                isFlipped.toggle()
            }
        }
        .rotation3DEffect(
            .degrees(isFlipped ? 180 : 0),
            axis: axis,
            anchor: .center,
            anchorZ: 0.0,
            perspective: 1.0
        )
        
        
    }
}

struct BadgeCardView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeCardView(badge: BadgeModel.example, isPlaying: false) { 
            print("playing")
        }
    }
}

extension BadgeCardView {
    private var notFlippedView: some View {
        Image(badge.badgeImageName)
            .resizable()
            .frame(width: 300, height: 300)
    }
    
    private var flippedView: some View {
        VStack(spacing: 10) {
            Spacer()
            Button(action: {
                performPlay()
            }, label: {
                HStack {
                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
                        
                    Text("Listen")
                }
                .font(.title)
                .padding(.bottom, 30)
               
            })
            
            Text(badge.composerInfo)
                .font(.headline)
                .foregroundColor(.black)
            Text(badge.trackInfo)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text("\(badge.gotAt.formatted(date: .abbreviated, time: .omitted))")
                .font(.caption)
                .foregroundColor(.gray)
            Spacer()
        }
        .frame(width: 300, height: 300)
        .background(
            Rectangle()
                .foregroundColor(.white)
        )
        
        
    }
}
