import SwiftUI

struct NoteCardView: View {
    let card: CardModel
    @State private var showRemoveButton: Bool = false
    let enableRemove: Bool
    let selectedCardID: UUID?
    let performRemove: () -> ()
    
    init(card: CardModel, enableRemove: Bool = false, selectedCardID: UUID? = nil, performRemove: @escaping () -> Void) {
        self.card = card
        self.enableRemove = enableRemove
        self.selectedCardID = selectedCardID
        self.performRemove = performRemove
    }
    
    var body: some View {
        
        if let noteType = card.noteType {
            ZStack {
                
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(card.color.gradient)
                    .frame(width: 100, height: 150)
                
                Image(noteType.rawValue)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 60)
            } 
            .onTapGesture {
                 print("1")
                
                print("2")
                if enableRemove && selectedCardID == card.id {
                    print("3")
                    withAnimation(.easeInOut) { 
                        showRemoveButton.toggle()
                    }
                }
            }
            .overlay(alignment: .center) { 
                if showRemoveButton && selectedCardID == card.id {
                    Button(action: {
                        performRemove()
                        withAnimation(.easeInOut) { 
                            showRemoveButton = false
                        }
                        
                    }, label: {
                        Image(systemName: "trash.circle")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                    })
                    .background(
                        .ultraThinMaterial, in: Circle()
                    )
                    
                }
            }
        } else {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(.white)
                .frame(width: 100, height: 150)
                .overlay(
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(Color.black, style: StrokeStyle(lineWidth: 2, dash: [8]))
                )
        }
        
        
    }
}

struct NoteCardView_Previews: PreviewProvider {
    static var previews: some View {
        NoteCardView(card: CardModel.example, enableRemove: false) {
            print("remove")
        }
    }
}
