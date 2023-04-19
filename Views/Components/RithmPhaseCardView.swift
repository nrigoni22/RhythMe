import SwiftUI

struct RithmPhaseCardView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15, style: .continuous)
            .fill(.white)
            .frame(width: 100, height: 150)
    }
}

struct RithmPhaseCardView_Previews: PreviewProvider {
    static var previews: some View {
        RithmPhaseCardView()
    }
}
