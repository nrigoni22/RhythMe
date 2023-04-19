import SwiftUI

struct LearningView: View {
    @StateObject private var learningData = LearningData()
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
            .padding(.bottom, 50)
            HStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(learningData.learningCards) { card in 
                            LearningCardView(cardData: card) {
                                learningData.playTrack(learningModel: card)
                            }
                        }   
                    }
                }
                .scrollIndicators(.hidden, axes: .vertical)
                VStack(alignment: .leading) {
                    Text("Note duration - Music Theory")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom)
                    Text("Music notation has two main parts. These are pitch and rhythm. Let's focusing on the rhythm. Rhythm is notated by the different note values. These tell us how long to hold each note, and how the notes related to each other in time. We can think of note values as a pizza.  We can cut it in half, then in half again. We can keep cutting each slice in half to make smaller and smaller pieces. And each slice has a direct proportion to the others.")
                        .font(.title2)
                        .foregroundColor(.white)
                    
                }
                .padding(.leading)
                Spacer()
            }
            .padding([.leading, .trailing], 40)
        }
    }
}

struct LearningView_Previews: PreviewProvider {
    static var previews: some View {
        LearningView(navigationSelection: .constant(nil))
    }
}
